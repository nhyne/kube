package kube

namespace "\(x)": {
  _name: x
} for x in _namespaces

_namespaces: [
  "drone",
  "archiver",
  "utility",
]
