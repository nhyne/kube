package kube

_statefulSet "drone-\(_labels.env)": {

  _metadata
  serviceName: "drone"

  spec: {
    selector matchLabels: _labels
    template metadata labels: _labels
    template spec containers: [
      _container,
    ]
  }
}

_container: {
  image: "drone/drone:1.0.0"
  name:  "server"
  env: [{
    name:  "DRONE_KUBERNETES_ENABLED"
    value: "true"
  }, {
    name: "DRONE_KUBERNETES_NAMESPACE"
    value: "drone"
  }, {
    name: "DRONE_LOGS_DEBUG"
    value: "true"
  }, {
    name: "DRONE_ADMIN"
    value: "nhyne"
  }, {
    name: "DRONE_SERVER_HOST"
    value: "drone.nhyne.dev"
  }, {
    name: "DRONE_GITHUB_CLIENT_ID"
    value: "a633f44f1ac044185bb3"
  }, {
    name: "DRONE_TLS_AUTOCERT"
    value: "true"
  },{
    name: "DRONE_GITHUB_CLIENT_SECRET"
    valueFrom secretKeyRef: {
      name: "drone"
      key: "client_secret"
    }
    _secret: true
  },{
    name: "DRONE_RPC_SECRET"
    valueFrom secretKeyRef: {
      name: "drone"
      key: "drone_rpc_secret"
    }
    _secret: true
  }]
  ports: [{
    name:          "https-port"
    containerPort: 443
    protocol:      "TCP"
    _type: "LoadBalancer"
    _dnsName: "drone.nhyne.dev"
  }]
}

_metadata: {
  metadata: {
    name:      "drone-server"
    namespace: "drone"
    labels:    _labels
  }
}

_labels: {
  component: "drone"
  app:       "drone-server"
}

_clusterRoleBinding "drone-rbac-\(_labels.env)": {
  apiVersion: "rbac.authorization.k8s.io/v1beta1"
  kind:       "ClusterRoleBinding"
  metadata:{
    name: "drone-rbac"
    labels: _labels
  }
  subjects: [{
    kind:      "ServiceAccount"
    name:      "default"
    namespace: "drone"
  }]
  roleRef: {
    kind:     "ClusterRole"
    name:     "cluster-admin"
    apiGroup: "rbac.authorization.k8s.io"
  }
}
