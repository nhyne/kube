package kube

objects: [ x for v in objectSets for x in v ]

objectSets: [
	namespace,
	service,
	deployment,
	statefulSet,
	job,
	serviceAccount,
	clusterRole,
	clusterRoleBinding,
]
