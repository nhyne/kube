resource "google_sql_database_instance" "master" {
  name = "archiver"
  database_version = "POSTGRES_11"
  region = "us-central1"

  settings {
    tier = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size = 10
    maintenance_window {
      day = "2" // Tuesday
      hour = "8" // 4-5 AM UTC
    }
  }
}

data "google_dns_managed_zone" "nhyne_dev_zone" {
  name = "nhyne-dev"
}

resource "google_dns_record_set" "postgres" {
  name = "pg.nhyne.dev."
  type = "A"
  ttl  = 300

  managed_zone = data.google_dns_managed_zone.nhyne_dev_zone.name

  rrdatas = [google_sql_database_instance.master.public_ip_address]

}

resource "kubernetes_namespace" "archiver" {
  metadata {
    name = "archiver"
  }

  depends_on = [google_container_cluster.primary]
}


resource "kubernetes_endpoints" "postgres" {
  metadata {
    name = "postgres"
    namespace = kubernetes_namespace.archiver.metadata.0.name
  }

  subset {
    address {
      ip = google_sql_database_instance.master.public_ip_address
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
    name = kubernetes_endpoints.postgres.metadata.0.name
    namespace = kubernetes_namespace.archiver.metadata.0.name
  }

  spec {
    port {
      port        = 5432
      target_port = 5432
    }
  }

  depends_on = [google_container_cluster.primary]
}
