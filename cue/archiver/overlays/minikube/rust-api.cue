package kube

deployment "archiver-api": {
	// This exists so that diesel can run any needed migrations before
	//   the API tries to connect for the first time
	spec template spec initContainers: [{
		name:  "sleep"
		image: "alpine:3.10.1"
		command: ["sleep"]
		args: ["30"]
	}]
}
