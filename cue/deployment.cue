package kube

deployment: [Name=_]: _apps_selector_common_spec & {
	kind:       "Deployment"
	_flux:      *false | true
	_name:      Name
	_component: Name
	if _flux {
		metadata: annotations: "fluxcd.io/automated": "true"
	}
	spec: replicas:             *1 | int
	spec: revisionHistoryLimit: *10 | int
	spec: template: spec: {
		containers: [..._container_spec]
		initContainers: [..._container_spec]
	}
}
