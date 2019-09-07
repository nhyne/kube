package kube

deployment "archiver-api": {
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
	name:  "archiver-api"
	env: [{
		name:  "DATABASE_URL"
		value: "postgres://something:somethingelse@postgres:5432/archiver"
	}]
	ports: [{
		name:          "something"
		containerPort: 8000
		protocol:      "TCP"
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
