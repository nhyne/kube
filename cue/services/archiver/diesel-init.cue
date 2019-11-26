package kube

_git_sync_container: {
	name:  "git-sync"
	image: "nhyne/git-sync:1.0.0__linux_amd64"
	command: ["/git-sync"]
	args: ["--repo=https://github.com/nhyne/archiver-api", "--branch=\(_git_sync_branch)", "--one-time"]
	volumeMounts: [{
		name:      "git"
		mountPath: "/tmp/git"
	}]
}

_diesel_container: {
	name:  "diesel"
	image: "nhyne/diesel-cli:postgres-11.4"
	command: ["diesel"]
	args: ["migration", "run"]
	workingDir: "/home/archiver-api/"
	env: [{
		name: "DATABASE_URL"
		valueFrom: secretKeyRef: {
			name: "archiver"
			key:  "database_url"
		}
		_secret: true
	}]
	volumeMounts: [{
		name:      "git"
		mountPath: "/home"
	}]
}

_diesel_migration_status_container: {
	name:  "diesel-migration-status"
	image: "nhyne/diesel-cli:postgres-11.4"
	command: ["diesel"]
	args: ["migration", "list"]
	workingDir: "/home/archiver-api/"
	env: [{
		name: "DATABASE_URL"
		valueFrom: secretKeyRef: {
			name: "archiver"
			key:  "database_url"
		}
		_secret: true
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

_git_sync_branch: string
