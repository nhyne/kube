package kube

container: {
	name:  string
	image: string
	env: [...envType]
	ports: [...portType]
}

envType <Key>: string

envSpec <Key>: {}
envSpec: {"\(k)" value: v for k, v in envType}

portType: {
	name:          string
	protocol:      *"TCP" | "UDP"
	containerPort: >=0 & <=65535 & int
  _export:       *true | false
}


