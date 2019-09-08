package kube

_volume_spec: {
	_type: string
	name:  string
	emptyDir: {} if _type == "empty"
}

_volume_mount_spec: {
	name:      string
	mountPath: string
}

_volume_claim_template_spec: {
	metadata name: string
	spec: {
		accessModes: [...string]
		resources requests storage: string
	}
}
