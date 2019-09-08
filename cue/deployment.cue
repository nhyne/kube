package kube

deployment <Name>: _apps_selector_common_spec & {
	kind:       "Deployment"
	_flux:      *false | true
	_name:      Name
	_component: Name
	metadata annotations "fluxcd.io/automated": "true" if _flux
	spec replicas:             *1 | int
	spec revisionHistoryLimit: *10 | int
	spec template spec: {
		containers: [..._container_spec]
		initContainers: [..._container_spec]
	}
}
