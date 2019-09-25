package kube

deployment: _archiver_deployment & {}

_archiver_metadata: {
	metadata annotations "fluxcd.io/tag.rust": "semver:~0.1"
}
