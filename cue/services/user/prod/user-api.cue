package kube

deployment: _user_deployment & {}

_user_port: {
  _port:    80
  _type:    "LoadBalancer"
  _dnsName: "user.nhyne.dev"
}

_user_metadata: {
  metadata annotations "fluxcd.io/tag.rust": "semver:~0.1"
}
