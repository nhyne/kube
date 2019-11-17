package kube

_user_deployment "user-api-\(_labels.env)": {
  _user_metadata

  spec: {
    selector matchLabels: _user_labels
    template metadata labels: _user_labels
    template spec containers: [
      _user_container,
    ]
    template: spec: initContainers: [
      _git_sync_container,
      _diesel_container,
    ]
  }
}

_user_container: {
  image: *"nhyne/user-api:v0.1.1-alpha.1" | string
  name:  "rust"
  env: [{
    name: "DATABASE_URL"
    valueFrom secretKeyRef: {
      name: "user-db-pass"
      key:  "database_url"
    }
    _secret: true
  }]
  ports: [_user_port]
}

_user_port: {
  name:          "http"
  containerPort: 8001
  protocol:      "TCP"
  _nameOverride: "user-api"
}

_user_metadata: _metadata & {
  metadata: {
    name:   "user-api"
    labels: _user_labels
  }
}

_user_labels: _labels & {
  component: "user-api"
}

_diesel_container: {
  name:  "diesel"
  image: "nhyne/diesel-cli:postgres-11.4"
  command: ["diesel"]
  args: ["migration", "run"]
  workingDir: "/home/user-api/"
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

_git_sync_container: {
  name:  "git-sync"
  image: "nhyne/git-sync:1.0.0__linux_amd64"
  command: ["/git-sync"]
  args: ["--repo=https://github.com/nhyne/user-api", "--branch=\(_git_sync_branch)", "--one-time"]
  volumeMounts: [{
    name:      "git"
    mountPath: "/tmp/git"
  }]
}

_git_sync_branch: "master"
