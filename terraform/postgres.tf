resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
  name             = "postgres-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_11"
  region           = "us-central1"

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = 10

    ip_configuration {
      private_network = google_compute_network.kube_network.self_link
    }

    maintenance_window {
      day  = "2" // Tuesday
      hour = "8" // 4-5 AM UTC
    }
    backup_configuration {
      enabled    = true
      start_time = "08:00"
    }
  }

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]
}

resource "google_sql_database" "database" {
  name     = "archiver"
  instance = google_sql_database_instance.master.name
}

resource "google_sql_user" "users" {
  name       = var.archiver_db_username
  instance   = google_sql_database_instance.master.name
  password   = var.archiver_db_password
  depends_on = [google_sql_database_instance.master]
}

resource "google_sql_database" "users_database" {
  name     = "users"
  instance = google_sql_database_instance.master.name
}

resource "google_sql_user" "users_user" {
  name       = var.user_db_username
  instance   = google_sql_database_instance.master.name
  password   = var.user_db_password
  depends_on = [google_sql_database_instance.master]
}

resource "google_dns_record_set" "postgres" {
  name = "pg.nhyne.dev."
  type = "A"
  ttl  = 300

  managed_zone = data.google_dns_managed_zone.nhyne_dev_zone.name

  rrdatas = [google_sql_database_instance.master.private_ip_address]

}

// Networking stuff

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.kube_network.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.kube_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}



// Kubernetes stuff

resource "kubernetes_namespace" "database" {
  metadata {
    name = "database"
  }

  depends_on = [google_container_cluster.primary, null_resource.update_kubeconfig]
}


resource "kubernetes_endpoints" "postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.database.metadata.0.name
  }

  subset {
    address {
      ip = google_sql_database_instance.master.private_ip_address
    }

    port {
      name     = "postgres"
      port     = 5432
      protocol = "TCP"
    }
  }

  depends_on = [google_container_cluster.primary]
}

resource "kubernetes_service" "postgres" {
  metadata {
    name      = kubernetes_endpoints.postgres.metadata.0.name
    namespace = kubernetes_namespace.database.metadata.0.name
  }

  spec {
    port {
      port        = 5432
      target_port = 5432
    }
  }

  depends_on = [google_container_cluster.primary]
}
