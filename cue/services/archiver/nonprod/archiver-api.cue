package kube

deployment: _deployment & {
}

_labels: {
  env: "nonprod"
}

_archiver_labels: _labels & {
  component: "archiver-api"
}

_deployment "archiver-api-nonprod": {
  _archiver_metadata
  _flux: true
  spec selector matchLabels: _archiver_labels
  spec template metadata labels: _archiver_labels
  spec template spec initContainers: [{
    name: "sleep"
    image: "alpine:3.10.1"
    command: ["sleep"]
    args: ["30"]
  }]
}

_archiver_metadata: _metadata & {
  metadata: {
    name:      "archiver-api"
    labels: _archiver_labels
  }
}
