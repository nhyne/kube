package kube

service postgres spec ports: [{
	port:       5432
	targetPort: 5432
}]
endpoints postgres: {
	kind:       "Endpoints"
	apiVersion: "v1"
	metadata: {
		name: "postgres"
		labels: {
			app:       "postgres"
			component: "archiver-api"
		}
	}
	subsets: [{
		addresses: [{
			ip: "10.0.2.2"
		}]
		ports: [{port: 5432}]
	}]
}
