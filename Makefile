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
      --plaintext-file ./services/${ENV}/nogit/secrets.yaml \
      --ciphertext-file ./services/${ENV}/secrets.yaml.enc

decrypt_secrets:
	gcloud kms decrypt \
      --key secrets \
      --keyring kubernetes \
      --location global \
      --plaintext-file ./services/${ENV}/nogit/secrets.yaml \
      --ciphertext-file ./services/${ENV}/secrets.yaml.enc

secrets: context decrypt_secrets
	kubectl apply -f ./services/${ENV}/nogit/secrets.yaml

flux: context
	kubectl apply -f ./services/non-flux/${ENV}/flux/

install_flux: namespaces flux secrets

namespaces:
	find ./services/${ENV}/cluster/ -name "*-namespace.yml" -exec sh -c "kubectl apply -f {} ;" \;

sync_flux:
	fluxctl sync --k8s-fwd-ns flux

generate_local_cert:
	./scripts/localhost.sh
