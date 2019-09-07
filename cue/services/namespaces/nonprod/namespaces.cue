package kube

namespace "\(x)-\(_labels.env)": {
  _name: x
  metadata labels: _labels
} for x in _namespaces

_labels env: "nonprod"
