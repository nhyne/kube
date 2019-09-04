package kube

deployment <Name>: _spec & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	_name:      Name
	_component: Name
	spec replicas:             *1 | int
	spec revisionHistoryLimit: *10 | int
}

service "\(k)": {
    apiVersion: "v1"
    kind:       "Service"

    spec selector: v.spec.template.metadata.labels

    spec ports: [ {
        Port = p.containerPort // Port is an alias
        port:       *Port | int
        targetPort: *Port | int
    } for c in v.spec.template.spec.containers
        for p in c.ports
        if p._export ]

} for x in [deployment] for k, v in x
