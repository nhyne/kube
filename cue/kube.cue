daemonSet <Name>: _spec & {
    apiVersion: "apps/v1"
    kind:       "DaemonSet"
    _name:      Name
}

statefulSet <Name>: _spec & {
    apiVersion: "apps/v1"
    kind:       "StatefulSet"
    _name:      Name
}

deployment <Name>: _spec & {
    apiVersion: "apps/v1"
    kind:       "Deployment"
    _name:      Name
    spec replicas: *1 | int
}

configMap <Name>: {
    metadata name: Name
    metadata labels component: _component
}

_spec: {
    _name: string
    metadata name: _name
    metadata labels component: _component
    spec template: {
        metadata labels: {
            app:       _name
            component: _component
            env:    string
        }
        spec containers: [{name: _name}]
    }
}

_spec spec template spec containers: [...{
    ports: [...{
        _export: *true | false // include the port in the service
    }]
}]

service "\(k)": {
    spec selector: v.spec.template.metadata.labels

    spec ports: [ {
        Port = p.containerPort // Port is an alias
        port:       *Port | int
        targetPort: *Port | int
    } for c in v.spec.template.spec.containers
        for p in c.ports
        if p._export ]

} for x in [deployment, daemonSet, statefulSet] for k, v in x
