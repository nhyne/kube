package kube

service "\(k)-\(con.name)-\(p.name)": {
  apiVersion: "v1"
  kind:       "Service"
  metadata: {
    AppMeta = v.metadata
    namespace: AppMeta.namespace
    labels: AppMeta.labels
    name: "\(k)-\(con.name)-\(p.name)"
    annotations "external-dns.alpha.kubernetes.io/hostname": p._dns_name if p._type == "LoadBalancer"
  }
  type:       p._type

  spec selector: v.spec.template.metadata.labels
  spec ports: [ {
    Port = p["containerPort"] // Port is an alias
    port:       *p._port | Port
    targetPort: Port
  } ]

} for x in [deployment, statefulSet] for k, v in x
  for con in v.spec.template.spec.containers
  for p in con.ports
  if p._export

serivce <Name>: _metadata_common_spec & {
  
}
