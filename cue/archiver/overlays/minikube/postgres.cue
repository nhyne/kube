package kube

deployment postgres: {
	metadata labels: {
		app:       "postgres"
		component: "archiver-api"
	}
	spec: {
		revisionHistoryLimit: 10
		selector matchLabels app: "postgres"
		template spec containers: [{
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
				containerPort: 5432
				protocol:      "TCP"
			}]
		}]
	}
}
service postgres spec ports: [{
	port:       5432
	targetPort: 5432
}]
