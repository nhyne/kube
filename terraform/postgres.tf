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
      hour = "4" // 4-5 AM
    }
  }
}
