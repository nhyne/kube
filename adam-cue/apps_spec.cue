package kube

_spec: {
	_component: string
	_name:      string
	metadata name: _name
	metadata labels component: _component
	spec template: {
		metadata labels: {
			app:       string
			component: _component
			env:       string
		}
		spec containers: [{name: _name}]
	}
}

_spec spec template spec containers: [...{
	ports: [...{
		_export: *true | false // include the port in the service
	}]
}]
