package kube

deployment: _archiver_deployment & {
}

_archiver_deployment "archiver-api-nonprod": {
	_archiver_metadata

	spec template spec initContainers: [{
		name:  "sleep"
		image: "alpine:3.10.1"
		command: ["sleep"]
		args: ["30"]
	}]
}

_archiver_metadata: {
	metadata annotations "fluxcd.io/tag.rust": "regex:.*"
}
