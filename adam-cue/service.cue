package kube

// TODO: Need to have a better
service "\(k)": {
  apiVersion: "v1"
  kind:       "Service"
  metadata:   v.metadata

  spec selector: v.spec.template.metadata.labels
  spec ports: [ {
    Port = p["containerPort"] // Port is an alias
    port:       *Port | int
    targetPort: *Port | int
  } for con in v.spec.template.spec.containers
    for p in con.ports
    if p._export ]

} for x in [deployment, statefulSet] for k, v in x
