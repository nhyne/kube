package kube

namespace <Name>: {
  _name: string
  kind: "v1"
  type: "Namespace"
  metadata: {
    name: *_name | string
    labels name: *_name | string
  }
}
