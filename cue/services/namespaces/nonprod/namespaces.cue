package kube

for x in _namespaces for k, v in x {
	namespace "\(k)-\(_labels.env)": {
		_name: k
		metadata labels: _labels
		if v {
			metadata labels: {
				"istio-injection": "enabled"
			}
		}
	}
}

_labels env: "nonprod"
