package kube

deployment: [Name=_]: _apps_selector_common_spec & {
	kind:       "Deployment"
	_name:      Name
	_component: Name
	spec: replicas:             *1 | int
	spec: revisionHistoryLimit: *10 | int
	spec: template: spec: {
		containers: [..._container_spec]
		initContainers: [..._container_spec]
	}
}
