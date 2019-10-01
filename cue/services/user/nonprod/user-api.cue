package kube

deployment: _user_deployment & {
}

_user_port: {
  _port:    80
  _type:    "NodePort"
}

_user_deployment "user-api-nonprod": {
  _user_metadata
    metadata annotations "fluxcd.io/tag.sleep": "semver:~3.10.1"

  spec template spec initContainers: [{
    name:  "sleep"
    image: "alpine:3.10.1"
    command: ["sleep"]
    args: ["30"]
  }]
}
