package kube

deployment: _user_deployment & {
}

_user_deployment "user-api-nonprod": {
  _user_metadata

  spec template spec initContainers: [{
    name:  "sleep"
    image: "alpine:3.10.1"
    command: ["sleep"]
    args: ["30"]
  }]
}
