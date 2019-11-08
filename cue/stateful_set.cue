package kube

statefulSet: [Name=_]: _apps_selector_common_spec & {
	kind:       "StatefulSet"
	_name:      Name
	_component: Name
	spec: serviceName: string
	spec: replicas:    *1 | int
	spec: template: spec: containers: [..._container_spec]
}
