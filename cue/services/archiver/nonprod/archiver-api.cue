package kube

deployment: _deployment & {
}

/*
_deployment: {
  spec template spec initContainers: [{
    name: "sleep"
    image: "alpine:3.10.1"
    command: ["sleep"]
    args: ["30"]
  }]
}
*/

_labels: {
  env: "nonprod"
}

