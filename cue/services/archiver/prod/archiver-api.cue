package kube

deployment: _deployment & {} 

_labels: {
  env: "prod"
}

_port: {
    _port: 443
    _type: "LoadBalancer"
    _dns_name: "archiver.nhyne.dev"
  }
