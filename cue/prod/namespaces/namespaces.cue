package kube

namespace "\(x)": {
  _name: x
  metadata labels: _labels
} for x in _namespaces

_namespaces: [
  "drone",
  "archiver",
  "utility",
]
