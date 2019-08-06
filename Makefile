CLUSTER_NAME:=nhyne-cluster
CLUSTER_ZONE:=us-central1-a

namespaces:
	parallel "kubectl apply -f {}" ::: kube/shared/namespaces/*.yml

gcp_argo:
	argocd app create drone \
  --repo https://github.com/nhyne/kube.git \
  --path kube/gcp/drone \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace drone \
  --sync-policy automated \
  --revision master \
  --directory-recurse \
  --auto-prune

install_linkerd:
	linkerd install | kubectl apply -f -
