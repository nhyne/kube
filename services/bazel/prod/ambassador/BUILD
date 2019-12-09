load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")

_CLUSTER = "gke_nhyne-233223_us-central1-a_nhyne-cluster"
_CONTEXT = "nhyne"

k8s_object(
    name = "ambassador-core",
    template = ":ambassador-core.yaml",
    cluster = _CLUSTER,
    context = _CONTEXT,
)

k8s_object(
    name = "ambassador-deploy",
    template = ":deployment.yaml",
    kind = "deployment",
    cluster = _CLUSTER,
    context = _CONTEXT,
)

k8s_object(
    name = "ambassador-service",
    template = ":service.yaml",
    kind = "service",
    cluster = _CLUSTER,
    context = _CONTEXT,
)

k8s_object(
    name = "ambassador-tls-context",
    template = ":tls-context.yaml",
    cluster = _CLUSTER,
    context = _CONTEXT,
)

k8s_object(
    name = "ambassador-mappings",
    template = ":mappings.yaml",
    cluster = _CLUSTER,
    context = _CONTEXT,
)

k8s_object(
    name = "ambassador-namespace",
    template = ":namespace.yaml",
    kind = "namespace",
    cluster = _CLUSTER,
    context = _CONTEXT,
)

k8s_objects(
    name = "ambassador",
    objects = [
        ":ambassador-namespace",
        ":ambassador-core",
        ":ambassador-deploy",
        ":ambassador-service",
        ":ambassador-mappings",
        ":ambassador-tls-context",
    ]
)
