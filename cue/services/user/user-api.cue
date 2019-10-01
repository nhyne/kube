package kube

_user_deployment "user-api-\(_labels.env)": {
  _user_metadata

  spec: {
    selector matchLabels: _user_labels
    template metadata labels: _user_labels
    template spec containers: [
      _user_container,
    ]
  }
}

_user_container: {
  image: *"nhyne/user-api:0.1.1-beta.3" | string
  name:  "rust"
  env: [{
    name: "DATABASE_URL"
    valueFrom secretKeyRef: {
      name: "user"
      key:  "database_url"
    }
    _secret: true
  }]
  ports: [_user_port]
}

_user_port: {
  name:          "http"
  containerPort: 8001
  protocol:      "TCP"
}

_user_metadata: _metadata & {
  metadata: {
    name:   "user-api"
    labels: _user_labels
    annotations: {
      "fluxcd.io/automated": "true"
    }
  }
}

_user_labels: _labels & {
  component: "user-api"
}
