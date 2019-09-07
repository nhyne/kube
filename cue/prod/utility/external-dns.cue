package kube

deployment "external-dns": {
  _external_dns_metadata

  spec: {
    selector matchLabels: _external_dns_labels
    template metadata labels: _external_dns_labels
    template spec:{
      serviceAccountName: "external-dns"
      containers: [
        _external_dns_container,
      ]
    }
  }
}

_external_dns_container: {
  image: "registry.opensource.zalan.do/teapot/external-dns:v0.5.11"
  name: "external-dns"
  args: [
   "--source=service",
   "--source=ingress",
   "--domain-filter=nhyne.dev",
   "--domain-filter=nhyne.io",
   "--domain-filter=adamjohnson.dev",
   "--domain-filter=johnsona.dev",
   "--provider=google",
   "--registry=txt",
   "--txt-owner-id=nhyne-kube-utility ",
  ]
}

_external_dns_metadata: {
  metadata: {
    name: "external-dns"
    namespace: "utility"
    labels: _external_dns_labels
  }
}

_external_dns_labels: {
  app: "external-dns"
  component: "external-dns"
  env: "prod"
}

serviceAccount "external-dns": {
  apiVersion: "v1"
  kind:       "ServiceAccount"
  metadata name: "external-dns"
}
clusterRole "external-dns": {
  apiVersion: "rbac.authorization.k8s.io/v1beta1"
  kind:       "ClusterRole"
  metadata name: "external-dns"
  rules: [{
    apiGroups: [""]
    resources: ["services"]
    verbs: ["get", "watch", "list"]
  }, {
    apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "watch", "list"]
  }, {
    apiGroups: ["extensions"]
    resources: ["ingresses"]
    verbs: ["get", "watch", "list"]
  }, {
    apiGroups: [""]
    resources: ["nodes"]
    verbs: ["list"]
  }]
}
clusterRoleBinding "external-dns-viewer": {
  apiVersion: "rbac.authorization.k8s.io/v1beta1"
  kind:       "ClusterRoleBinding"
  metadata name: "external-dns-viewer"
  roleRef: {
    apiGroup: "rbac.authorization.k8s.io"
    kind:     "ClusterRole"
    name:     "external-dns"
  }
  subjects: [{
    kind:      "ServiceAccount"
    name:      "external-dns"
    namespace: "utility"
  }]
}
