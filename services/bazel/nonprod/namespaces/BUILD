load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")

_CLUSTER = "minikube"
_CONTEXT = "minikube"

k8s_object(
    name = "archiver-namespace",
    template = ":archiver.yaml",
    kind = "namespace",
    context = _CONTEXT,
    cluster = _CLUSTER,
)

k8s_object(
    name = "build-namespace",
    template = ":build.yaml",
    kind = "namespace",
    context = _CONTEXT,
    cluster = _CLUSTER,
)

k8s_object(
    name = "user-namespace",
    template = ":user.yaml",
    kind = "namespace",
    context = _CONTEXT,
    cluster = _CLUSTER,
)

k8s_object(
    name = "utility-namespace",
    template = ":utility.yaml",
    kind = "namespace",
    context = _CONTEXT,
    cluster = _CLUSTER,
)

k8s_objects(
    name = "namespaces",
    objects = [
        ":archiver-namespace",
        ":build-namespace",
        ":user-namespace",
        ":utility-namespace",
    ]
)
