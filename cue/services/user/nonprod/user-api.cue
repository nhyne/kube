package kube

deployment: _user_deployment & {
}

_user_deployment "user-api-nonprod": {
  _user_metadata
}
