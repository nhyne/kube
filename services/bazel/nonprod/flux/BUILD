# flux yaml files generated with
# fluxctl install \
#   --git-user=flux-ci \
#   --git-email=flux@nhyne.dev \
#   --git-url=https://github.com/nhyne/kube.git \
#   --git-branch=develop \
#   --git-path=services/nonprod \
#   --namespace=flux


load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")

k8s_objects(
    name = "flux",
    objects = [
        ":flux-namespace",
        ":secret",
        ":service-account",
        ":cluster-role",
        ":cluster-role-binding",
        ":memcache-deploy",
        ":memcache-service",
        ":flux-deploy",
    ]
)

k8s_object(
  name = "flux-deploy",
  template = ":deployment.yaml",
  kind = "deployment",
  cluster = "minikube",
  context = "minikube",
)

k8s_object(
    name = "flux-namespace",
    template = ":namespace.yaml",
    kind = "namespace",
    cluster = "minikube",
    context = "minikube"
)

k8s_object(
  name = "memcache-deploy",
  template = ":memcache-deployment.yaml",
  kind = "deployment",
  cluster = "minikube",
  context = "minikube",
)

k8s_object(
  name = "memcache-service",
  template = ":memcache-service.yaml",
  kind = "service",
  cluster = "minikube",
  context = "minikube",
)

k8s_object(
  name = "cluster-role",
  template = ":cluster-role.yaml",
  kind = "cluster-role",
  cluster = "minikube",
  context = "minikube",
)

k8s_object(
  name = "cluster-role-binding",
  template = ":cluster-role-binding.yaml",
  kind = "cluster-role-binding",
  cluster = "minikube",
  context = "minikube",
)

k8s_object(
  name = "service-account",
  template = ":service-account.yaml",
  kind = "service-account",
  cluster = "minikube",
  context = "minikube",
)

k8s_object(
  name = "secret",
  template = ":secret.yaml",
  kind = "secret",
  cluster = "minikube",
  context = "minikube",
)
