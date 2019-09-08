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
	name:    string
	value:   string if !_secret
	_secret: *false | true
	valueFrom: {
		secretKeyRef: {
			name: string
			key:  string
		}
	} if _secret
}

_port_spec: {
	name:          string
	protocol:      *"TCP" | "UDP"
	containerPort: >=0 & <=65535 & int
	_targetPort:   *containerPort | >=0 & <=65535 & int
	_port:         *_targetPort | >=0 & <=65535 & int
	_export:       *true | false
	_type:         *"ClusterIP" | string if _export
	_dnsName:      string if _type == "LoadBalancer"
}
