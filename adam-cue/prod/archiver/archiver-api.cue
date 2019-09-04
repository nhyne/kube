package kube

deployment "archiver-api": {
	spec: {
		selector matchLabels app: "archiver-api"
		template spec containers: [{
			image: "nhyne/archiver-api:0.0.1-alpha"
			env: [{
				name:  "DATABASE_URL"
				value: "postgres://something:somethingelse@postgres:5432/archiver"
			}]
			ports: [{
				containerPort: 8000
				protocol:      "TCP"
			}]
		}]
	}
}
