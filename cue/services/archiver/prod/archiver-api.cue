package kube

deployment: _archiver_deployment & {}

_archiver_port: {
	_port:    80
	_type:    "LoadBalancer"
	_dnsName: "archiver.nhyne.dev"
}
