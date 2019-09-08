package kube

deployment: _deployment & {}

_labels: {
	env:       "prod"
	component: "archiver-api"
}

_port: {
	_port:    443
	_type:    "LoadBalancer"
	_dnsName: "archiver.nhyne.dev"
}

_metadata: {
	metadata: {
		name: "archiver-api"
	}
}
