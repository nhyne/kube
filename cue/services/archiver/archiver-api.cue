package kube

_deployment "archiver-api\(_labels.env)": {
	_metadata

	spec: {
		selector matchLabels: _labels
		template metadata labels: _labels
		template spec containers: [
			_container,
		]
	}
}

_container: {
	image: "nhyne/archiver-api:0.0.1-alpha"
	name:  "rust"
	env: [{
		name:  "DATABASE_URL"
		value: "postgres://something:somethingelse@postgres:5432/archiver"
	}]
	ports: [{
		name:          "http"
		targetPort: 8000
		port: 443
		protocol:      "TCP"
		_type: "LoadBalancer"
		_dns_name: "archiver.nhyne.dev"
	}]
}

_metadata: {
	metadata: {
		name:      "archiver-api"
		namespace: "archiver"
		labels:    _labels
	}
}

_labels: {
	component: "archiver-api"
	app:       "rust"
}
