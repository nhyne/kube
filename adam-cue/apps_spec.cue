package kube

_metadata_common_spec: {
	metadata: {
		name:      string
		namespace: *"default" | string
		labels: {
			env:      string
			componen: string
			app:      string
		}
	}
	_component: string
	_env:       string
	_name:      string
	_app:       *_name | string
	metadata name: _name
	metadata labels: {
		component: _component
		env:       _env
		app:       _app
	}
}

_apps_common_spec: _metadata_common_spec & {
	spec template: {
		metadata labels: {
			app:       _metadata_common_spec._app
			component: _metadata_common_spec._component
			env:       _metadata_common_spec._env
		}
		//spec containers: [{name: _name}]
	}
}
/*
_spec spec template spec containers: [...{
	ports: [...{
		_export: *true | false // include the port in the service
	}]
}]
*/
