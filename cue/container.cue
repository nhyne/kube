package kube

_container_spec: {
	name:  string
	image: string
	env: [..._env_spec]
	ports: [..._port_spec]
  args: [...string]
}

_env_spec: {
	name:  string
	value: string if !_secret
	_secret: *false | true
	valueFrom: {
    secretKeyRef: {
      name: string
      key: string
    }
	} if _secret
}

_port_spec: {
	name:          string
	protocol:      *"TCP" | "UDP"
  targetPort:    >=0 & <=65535 & int
	port:          *targetPort | >=0 & <=65535 & int
	_export:       *true | false
	_type:				 *"ClusterIp" | string if _export
  _dns_name:     string if _type == "LoadBalancer"
}
