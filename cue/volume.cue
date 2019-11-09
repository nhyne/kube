package kube

_volume_spec: {
	_type: string
	name:  string
	if _type == "empty" {
		emptyDir: {}
	}
	if _type == "secret" {
		secret: secretName: string
	}
}

_volume_mount_spec: {
	name:      string
	mountPath: string
	readOnly:  *false | bool
}

_volume_claim_template_spec: {
	metadata: name: string
	spec: {
		accessModes: [...string]
		resources: requests: storage: string
	}
}
