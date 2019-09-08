CLUSTER_NAME:=nhyne-cluster
CLUSTER_ZONE:=us-central1-a
ENV:=nonprod
BRANCH:=master

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

install_flux:
	fluxctl install \
	--git-user=flux-ci \
	--git-email=flux@nhyne.dev \
	--git-url=git@github.com:nhyne/kube \
	--git-branch=${BRANCH} \
	--git-path=services/${ENV} \
	--namespace=flux | kubectl apply -f -

namespaces:
	find ./services/${ENV}/cluster/ -name "*-namespace.yml" -exec sh -c "kubectl apply -f {} ;" \;

flux_sync:
	fluxctl sync --k8s-fwd-ns flux
