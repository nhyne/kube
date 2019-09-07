package kube

_metadata_common_spec: {
	metadata: {
		name:      string
		namespace: string
		labels:    _common_labels_spec
	}
}

_apps_common_spec: _metadata_common_spec & {
	apiVersion: *"apps/v1" | string
	spec: {
		template: {
			spec serviceAccountName: *"default" | string
			metadata labels: _common_labels_spec
		}
	}
}

_apps_selector_common_spec: _apps_common_spec & {
	spec selector matchLabels: _common_labels_spec
}

_common_labels_spec: {
	component: string
	env:       string
	app:       string
}
