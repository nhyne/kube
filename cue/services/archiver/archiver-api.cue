package kube

_archiver_deployment: "archiver-api-\(_labels.env)": {
	_archiver_metadata

	spec: {
		selector: matchLabels: _archiver_labels
		template: metadata: labels: _archiver_labels
		template: spec: containers: [
			_archiver_container,
		]
		template: spec: initContainers: [
			_git_sync_container,
			_diesel_container,
		]
	}
}

_archiver_container: {
	image: *"nhyne/archiver-api:v0.1.2-alpha.2" | string
	name:  "rust"
	env: [{
		name: "DATABASE_URL"
		valueFrom: secretKeyRef: {
			name: "archiver"
			key:  "database_url"
		}
		_secret: true
	}]
	ports: [_archiver_port]
}

_archiver_port: {
	name:          "http"
	containerPort: 8000
	protocol:      "TCP"
	_nameOverride: "archiver-api"
}

_archiver_metadata: _metadata & {
	metadata: {
		name:   "archiver-api"
		labels: _archiver_labels
		annotations: {
		}
	}
}

_archiver_labels: _labels & {
	component: "archiver-api"
}
