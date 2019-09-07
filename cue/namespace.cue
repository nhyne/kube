package kube

namespace <Name>: {
  _name: string
  apiVersion: "v1"
  kind: "Namespace"
  metadata: {
    name: *_name | string
    labels name: *_name | string
  }
}
