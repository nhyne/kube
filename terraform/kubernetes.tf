resource "google_container_cluster" "primary" {
  name     = "nhyne-cluster"
  location = "us-central1-a"

  remove_default_node_pool = true
  initial_node_count       = 1

  logging_service = "none"

  master_auth {
    username = ""
    password = ""
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "nhyne-primary-nodes"
  location = "us-central1-a"
  cluster  = google_container_cluster.primary.name

  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "g1-small"
    disk_size_gb = 25

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

