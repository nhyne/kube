package kube

_container_spec: {
	name:  string
	image: string
	env: [..._env_spec]
	ports: [..._port_spec]
	args: [...string]
	command: [...string]
	volumeMounts: [..._volume_mount_spec]
}

_env_spec: {
	name: string
	if !_secret {
		value: string
	}
	_secret: *false | true
	if _secret {
		valueFrom: {
			secretKeyRef: {
				name: string
				key:  string
			}
		}
	}
}

_port_spec: {
	name:          string
	protocol:      *"TCP" | "UDP"
	containerPort: >=0 & <=65535 & int
	_targetPort:   *containerPort | >=0 & <=65535 & int
	_port:         *_targetPort | >=0 & <=65535 & int
	_export:       *true | false
	if _export {
		_type: *"ClusterIP" | string
	}
	if _type == "LoadBalancer" {
		_dnsName: string
	}
}
