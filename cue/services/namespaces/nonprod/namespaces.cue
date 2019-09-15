package kube

for x in _namespaces {
	namespace "\(x)-\(_labels.env)": {
		_name: x
		metadata labels: _labels
	}
}

_labels env: "nonprod"
