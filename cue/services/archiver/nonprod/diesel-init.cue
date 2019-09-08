package kube

job "diesel-init": {
	_diesel_init_metadata

	spec: {
		template spec restartPolicy: "Never"
		template metadata labels:    _diesel_init_labels
		template spec containers: [
			_diesel_container,
		]
		template spec initContainers: [
			_git_sync_container,
			_ls_container,
		]
		template spec volumes: [{
			name:  "git"
			_type: "empty"
		}]
	}
}

_git_sync_container: {
	name:  "git-sync"
	image: "nhyne/git-sync:1.0.0__linux_amd64"
	command: ["/git-sync"]
	args: ["--repo=https://github.com/nhyne/archiver-api", "--branch=develop", "--one-time"]
	volumeMounts: [{
		name:      "git"
		mountPath: "/tmp/git"
	}]
}

_ls_container: {
	name:  "ls"
	image: "alpine:latest"
	command: ["ls"]
	args: ["-la", "/home/archiver-api"]
	volumeMounts: [{
		name:      "git"
		mountPath: "/home"
	}]
}

_diesel_container: {
	name:  "diesel"
	image: "nhyne/diesel-cli:postgres-11.4"
	command: ["diesel"]
	args: ["setup"]
	workingDir: "/home/archiver-api/"
	env: [{
		name:  "DATABASE_URL"
		value: "postgres://something:somethingelse@postgres:5432/archiver"
	}]
	volumeMounts: [{
		name:      "git"
		mountPath: "/home"
	}]
}

_diesel_init_metadata: _metadata & {
	metadata: {
		name:   "diesel-init"
		labels: _diesel_init_labels
	}
}

_diesel_init_labels: _labels & {
	component: "database-init"
}
