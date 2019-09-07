package kube

deployment: _deployment & {
}

_labels: {
  env: "nonprod"
}

_deployment "archiver-api-nonprod": {
  spec template spec initContainers: [{
    name: "sleep"
    image: "alpine:3.10.1"
    command: ["sleep"]
    args: ["30"]
  }]
}

