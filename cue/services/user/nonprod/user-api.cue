package kube

deployment: _user_deployment & {
}

_user_deployment: "user-api-nonprod": {
	_user_metadata
}

_user_container: image: "nhyne/user-api:v0.1.1-alpha.2"
