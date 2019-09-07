package kube

job <Name>: _apps_common_spec & {
  apiVersion: "batch/v1"
  kind: "Job"
  spec template spec:{
    restartPolicy: string
    initContainers: [..._container_spec]
    containers: [..._container_spec]
    volumes: [..._volume_spec]
  }
}
