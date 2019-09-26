package kube

for x in _namespaces for k, v in x {
	namespace "\(k)-\(_labels.env)": {
		_name: k
		metadata labels: _labels
		metadata labels: {
			if v {
				"istio-injection": "enabled"
			}
		}
	}
}

_labels env: "prod"
