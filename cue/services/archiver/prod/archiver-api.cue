package kube

deployment: _archiver_deployment & {}

_archiver_port: {
	_port:    443
	_type:    "LoadBalancer"
	_dnsName: "archiver.nhyne.dev"
}
