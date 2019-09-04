package kube

statefulSet "drone-server": {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
	metadata: {
		name: "drone-server"
		labels app: "drone-server"
	}
	spec: {
		replicas:    1
		serviceName: "drone-server"
		selector matchLabels app: "drone-server"
		template: {
			metadata: {
				labels app:                      "drone-server"
				annotations "linkerd.io/inject": "enabled"
			}
			spec containers: [{
				name:  "drone-server"
				image: "drone/drone:1.0.0"
				env: [{
					name:  "DRONE_KUBERNETES_ENABLED"
					value: "true"
				}, {
					name:  "DRONE_KUBERNETES_NAMESPACE"
					value: "drone"
				}, {
					name:  "DRONE_LOGS_DEBUG"
					value: "true"
				}, {
					name:  "DRONE_ADMIN"
					value: "nhyne"
				}, {
					name:  "DRONE_SERVER_HOST"
					value: "drone.nhyne.dev"
				}, {
					name:  "DRONE_GITHUB"
					value: "true"
				}, {
					name:  "DRONE_GITHUB_CLIENT_ID"
					value: "a633f44f1ac044185bb3"
				}, {
					name:  "DRONE_TLS_AUTOCERT"
					value: "true"
				}, {
					name: "DRONE_GITHUB_CLIENT_SECRET"
					valueFrom secretKeyRef: {
						name: "drone"
						key:  "client_secret"
					}
				}, {
					name: "DRONE_RPC_SECRET"
					valueFrom secretKeyRef: {
						name: "drone"
						key:  "drone_rpc_secret"
					}
				}]
				ports: [{
					containerPort: 80
					name:          "http-port"
				}, {
					containerPort: 443
					name:          "https-port"
				}]
				volumeMounts: [{
					name:      "drone-home"
					mountPath: "/var/lib/drone"
				}]
			}]
		}
		volumeClaimTemplates: [{
			metadata name: "drone-home"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources requests storage: "1Gi"
			}
		}]
	}
}
service "drone-server": {
	metadata: {
		labels apps:                                             "drone-server"
		annotations "external-dns.alpha.kubernetes.io/hostname": "drone.nhyne.dev."
	}
	spec: {
		type: "LoadBalancer"
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http-port"
		}, {
			name:       "https"
			port:       443
			targetPort: "https-port"
		}]
	}
}
clusterRoleBinding "drone-rbac": {
	apiVersion: "rbac.authorization.k8s.io/v1beta1"
	kind:       "ClusterRoleBinding"
	metadata: {
		name: "drone-rbac"
		labels component: "drone"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "default"
		namespace: "drone"
	}]
	roleRef: {
		kind:     "ClusterRole"
		name:     "cluster-admin"
		apiGroup: "rbac.authorization.k8s.io"
	}
}
