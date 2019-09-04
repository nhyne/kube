package kube

job "diesel-setup": {
	kind:       "Job"
	apiVersion: "batch/v1"
	metadata: {
		labels app: "diesel"
		name: "diesel-setup"
	}
	spec template spec: {
		restartPolicy: "Never"
		initContainers: [{
			name:  "git-sync"
			image: "nhyne/git-sync:1.0.0__linux_amd64"
			command: ["/git-sync"]
			args: ["--repo=https://github.com/nhyne/archiver-api", "--branch=develop", "--one-time"]
			volumeMounts: [{
				mountPath: "/tmp/git"
				name:      "git"
			}]
		}, {
			name:  "ls"
			image: "alpine:latest"
			command: ["ls"]
			args: ["-la", "/home/archiver-api"]
			volumeMounts: [{
				mountPath: "/home"
				name:      "git"
			}]
		}]
		// need to clone the api repo to a directory
		containers: [{
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
				mountPath: "/home"
				name:      "git"
			}]
		}]
		// need to run diesel setup to execute the migrations and init the DB
		volumes: [{
			name: "git"
			emptyDir: {}
		}]
	}
}