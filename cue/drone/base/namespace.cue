package kube

namespace drone: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		name: "drone"
		labels name: "drone"
	}
}
