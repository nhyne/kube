resource "google_container_cluster" "primary" {
  name     = "nhyne-cluster"
  location = "us-central1-a"

  min_master_version = "1.13.7"

  remove_default_node_pool = true
  initial_node_count       = 1

  logging_service = "none"

  network    = google_compute_network.kube_network.self_link
  subnetwork = google_compute_subnetwork.central_subnetwork.self_link

  ip_allocation_policy {
    use_ip_aliases = true
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
    }
  }

    private_cluster_config {
      enable_private_nodes = true
      master_ipv4_cidr_block = "10.3.0.0/28"
    }

  master_auth {
    username = ""
    password = ""
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "nhyne-primary-nodes"
  location = "us-central1-a"
  cluster  = google_container_cluster.primary.name

  version = "1.12.8-gke.10"

  initial_node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 4
  }

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


resource "google_container_node_pool" "memory_nodes" {
  name     = "nhyne-memory-nodes"
  location = "us-central1-a"
  cluster  = google_container_cluster.primary.name

  version = "1.12.8-gke.10"

  initial_node_count = 1
  autoscaling {
    min_node_count = 0
    max_node_count = 3
  }

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
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
