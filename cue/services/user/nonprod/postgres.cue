package kube

deployment "something": {
  _user_postgres_metadata

  spec: {
    selector matchLabels: _user_postgres_labels
    template metadata labels: _user_postgres_labels
    template spec containers: [_user_postgres_container]
  }
}

_user_postgres_container: {
  name:  "postgres-user"
  image: "postgres:11.5-alpine"
  env: [{
    name:  "POSTGRES_USER"
    value: "something"
  }, {
    name:  "POSTGRES_PASSWORD"
    value: "somethingelse"
  }, {
    name:  "POSTGRES_DB"
    value: "user"
  }]
  ports: [{
    name:          "postgres"
    containerPort: 5432
    _nameOverride: "postgres-user"
  }]
}

_user_postgres_metadata: _metadata & {
  metadata: {
    name:   "user-postgres"
    labels: _user_postgres_labels
  }
}

_user_postgres_labels: _labels & {
  component: "database"
}
