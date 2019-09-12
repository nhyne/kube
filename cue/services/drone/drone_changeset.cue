package kube

_deployment "drone-changeset-\(_labels.env)": {
  _changeset_metadata

  spec: {
    selector matchLabels: _changeset_labels
    template metadata labels: _changeset_labels
    template spec containers: [
      _changeset_container,
    ]
  }
}

_changeset_container: {
  image: *"microadam/drone-config-plugin-pipeline:latest" | string
  name:  "drone-changeset"
  env: [{
      name: "GITHUB_TOKEN"
      valueFrom secretKeyRef: {
        name: "drone"
        key:  "changeset_github_key"
      }
      _secret: true
    },{
      name: "PLUGIN_SECRET"
      valueFrom secretKeyRef: {
        name: "drone"
        key:  "drone_rpc_secret"
      }
      _secret: true}]
  ports: [_changeset_port]
}

_changeset_port: {
  name:          "http"
  containerPort: 3000
  protocol:      "TCP"
  _nameOverride: "drone-changeset"
}

_changeset_metadata: _metadata & {
  metadata: {
    name: "drone-changeset"
    namespace: "drone"
    labels:    _changeset_labels
  }
}

_changeset_labels: _labels & {
  app: "drone-changeset"
}
