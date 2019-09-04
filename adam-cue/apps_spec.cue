package kube

_spec: {
	_component: string
	_env:				string
	_name:      string
	_app:				*_name|string
	metadata name: _name
	metadata labels: {
		component: _component
		env:			 _env
		app:			 _app
	}
	spec template: {
		metadata labels: {
			app:       _app
			component: _component
			env:       _env
		}
		spec containers: [{name: _name}]
	}
}

_spec spec template spec containers: [...{
	ports: [...{
		_export: *true | false // include the port in the service
	}]
}]
