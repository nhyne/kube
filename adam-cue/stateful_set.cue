package kube

statefulSet <Name>: _apps_common_spec & {
  kind: "StatefulSet"
  _name: Name
  _component: Name
  serviceName: string
  spec replicas: *1 | int
  spec template spec containers: [..._container]
}
