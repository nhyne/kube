ENV:=nonprod
BRANCH:=master

context:
ifeq ($(ENV), nonprod)
	kubectl config use-context minikube
else
	kubectl config use-context nhyne
endif

template:
	find services -name "*.yml" -delete
	cue files ./cue/...

encrypt_secrets:
	gcloud kms encrypt \
      --key secrets \
      --keyring kubernetes \
      --location global \
      --plaintext-file ./services/${ENV}/nogit/secrets.yml \
      --ciphertext-file ./services/${ENV}/secrets.yml.enc

decrypt_secrets:
	gcloud kms decrypt \
      --key secrets \
      --keyring kubernetes \
      --location global \
      --plaintext-file ./services/${ENV}/nogit/secrets.yml \
      --ciphertext-file ./services/${ENV}/secrets.yml.enc

secrets: context decrypt_secrets
	kubectl apply -f ./services/${ENV}/nogit/secrets.yml

flux: context
	fluxctl install \
	--git-user=flux-ci \
	--git-email=flux@nhyne.dev \
	--git-url=git@github.com:nhyne/kube \
	--git-branch=${BRANCH} \
	--git-path=services/${ENV} \
	--namespace=flux | kubectl apply -f -

install_flux: namespaces flux secrets

namespaces:
	find ./services/${ENV}/cluster/ -name "*-namespace.yml" -exec sh -c "kubectl apply -f {} ;" \;

sync_flux:
	fluxctl sync --k8s-fwd-ns flux

generate_local_cert:
	openssl genrsa -des3 -out local_server_pass.key 1024
	openssl req -new -key local_server_pass.key -out local_server.csr
	openssl x509 -req -days 365 -in local_server.csr -signkey local_server_pass.key -out local_server.crt
	openssl rsa -in local_server_pass.key -out local_server.key
