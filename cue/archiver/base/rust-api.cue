package kube

deployment "archiver-api": {
	metadata labels component: "archiver-api"
	spec: {
		revisionHistoryLimit: 10
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
service "archiver-api": {
	metadata namespace: "archiver"
	spec: {
		type: "LoadBalancer"
		ports: [{
			port:       443
			targetPort: 8000
		}]
	}
}
