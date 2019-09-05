package kube

statefulSet "drone": {

  _metadata
  serviceName: "drone"

  spec: {
    selector matchLabels: _labels
    template metadata labels: _labels
    template spec containers: [
      _container,
      //_container2,
    ]
  }
}

_container: {
  image: "nhyne/archiver-api:0.0.1-alpha"
  name:  "archiver-api"
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
  },{
    name:          "https2-port"
    containerPort: 443
    protocol:      "TCP"
  }]
}

_container2: {
  image: "nhyne/archiver-api:0.0.1-alpha"
  name:  "archiver-api"
  env: [{
    name:  "DRONE_KUBERNETES_ENABLED"
    value: "true"
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
  env:       "prod"
  app:       "drone-server"
}
