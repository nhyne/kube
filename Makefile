CLUSTER_NAME:=nhyne-cluster
CLUSTER_ZONE:=us-central1-a

generate_pks:
	openssl pkcs12 -inkey privkey.pem -in fullchain.pem -export -out jenkins.pkcs12
	keytool -importkeystore -srckeystore jenkins.pkcs12 -srcstoretype pkcs12 -destkeystore jenkins.jks

create_namespaces:
	parallel "kubectl apply -f {}" ::: kube/namespaces/*.yml
