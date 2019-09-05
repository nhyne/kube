package kube

_container: {
	name:  string
	image: string
	env: [..._env_spec]
	ports: [..._port_spec]
}

_env_spec: {
	name:  string
	value: string
}

_port_spec: {
	name:          string
	protocol:      *"TCP" | "UDP"
	containerPort: >=0 & <=65535 & int
	_export:       *true | false
}
