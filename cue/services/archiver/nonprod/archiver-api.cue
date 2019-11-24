package kube

deployment: _archiver_deployment & {
}

_archiver_port: {
	_port: 80
}

_archiver_deployment: "archiver-api-nonprod": {
	_archiver_metadata
}

_archiver_container: image: "nhyne/archiver-api:v0.1.2-alpha.4"
