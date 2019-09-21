package kube

deployment: _archiver_deployment & {}

_archiver_port: {
	_port:    80
	_type:    "LoadBalancer"
	_dnsName: "archiver.nhyne.dev"
}

_archiver_metadata: {
	metadata annotations "fluxcd.io/tag.rust": "semver:~0.1"
}
