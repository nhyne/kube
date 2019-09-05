package kube

deployment "archiver-api": {
	_env: "prod"
	spec: {
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
		//_export: false
	}]
}
