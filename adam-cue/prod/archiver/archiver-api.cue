package kube

deployment "archiver-api": {
	_archiver_metadata

	spec: {
		template metadata labels: _archiver_labels
		template spec containers: [
			_archiver_container,
		]
	}
}

_archiver_container: {
	image: "nhyne/archiver-api:0.0.1-alpha"
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

_archiver_metadata: {
	metadata: {
		name:      "archiver-api"
		namespace: "archiver"
		labels:    _archiver_labels
	}
}

_archiver_labels: {
	component: "archiver-api"
	env:       "prod"
	app:       "rust"
}
