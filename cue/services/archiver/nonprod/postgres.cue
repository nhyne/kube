package kube

deployment "postgres": {
	_postgres_metadata
	_flux: true

	spec: {
		selector matchLabels: _postgres_labels
		template metadata labels: _postgres_labels
		template spec containers: [_postgres_container]
	}
}

_postgres_container: {
	name:  "postgres"
	image: "postgres:11.5-alpine"
	env: [{
		name:  "POSTGRES_USER"
		value: "something"
	}, {
		name:  "POSTGRES_PASSWORD"
		value: "somethingelse"
	}, {
		name:  "POSTGRES_DB"
		value: "archiver"
	}]
	ports: [{
		name:          "postgres"
		containerPort: 5432
		_nameOverride: "postgres"
	}]
}

_postgres_metadata: _metadata & {
	metadata: {
		name:   "postgres"
		labels: _postgres_labels
	}
}

_postgres_labels: _labels & {
	component: "database"
}
