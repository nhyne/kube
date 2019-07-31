CLUSTER_NAME:=nhyne-cluster
CLUSTER_ZONE:=us-central1-a

generate_pks:
	openssl pkcs12 -inkey privkey.pem -in fullchain.pem -export -out jenkins.pkcs12
	keytool -importkeystore -srckeystore jenkins.pkcs12 -srcstoretype pkcs12 -destkeystore jenkins.jks

namespaces:
	parallel "kubectl apply -f {}" ::: kube/shared/namespaces/*.yml

encrypt_secrets:
	gcloud kms encrypt \
	--key jenkins \
	--keyring jenkins-secrets \
	--location global \
	--plaintext-file ./kube/nogit/secrets.yml \
	--ciphertext-file ./kube/enc_secrets/secrets

decrypt_secrets:
	gcloud kms decrypt \
	--key jenkins \
	--keyring jenkins-secrets \
	--location global \
	--plaintext-file ./kube/nogit/secrets.yml \
	--ciphertext-file ./kube/enc_secrets/secrets

secrets: decrypt_secrets
	kubectl apply -f ./kube/nogit/secrets.yml

minikube_argo:
	argocd app create jenkins \
  --repo https://github.com/nhyne/kube.git \
  --path kube/minikube/jenkins \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace jenkins \
  --sync-policy automated \
  --revision develop \
  --directory-recurse \
  --auto-prune
