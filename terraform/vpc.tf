resource "google_compute_network" "kube_network" {
  name                    = "kube-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "central_subnetwork" {
  name          = "central-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = "${google_compute_network.kube_network.self_link}"
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "kube-router"
  region  = google_compute_subnetwork.central_subnetwork.region
  network = google_compute_network.kube_network.self_link

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "kube-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "kube_vpc_firewall_https" {
  name    = "${google_container_cluster.primary.name}-allow-https-kube"
  network = google_compute_network.kube_network.name

  allow {
    protocol = "tcp"
    ports = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "kube_vpc_firewall_ssh" {
  name    = "${google_container_cluster.primary.name}-allow-ssh-kube"
  network = google_compute_network.kube_network.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
