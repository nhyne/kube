package kube

_metadata_common_spec: {
	metadata: {
		name:      string
		namespace: string
		labels:    _common_labels_spec
	}
}

_apps_common_spec: _metadata_common_spec & {
	spec template: {
		metadata labels: _common_labels_spec
		//spec containers: [{name: _name}]
	}
}

_common_labels_spec: {
	component: string
	env:       string
	app:       string
}
