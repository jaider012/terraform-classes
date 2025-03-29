# Create VPC network
resource "google_compute_network" "vpc" {
  name                    = "${var.network_name}-${terraform.workspace}"
  auto_create_subnetworks = false
}

# Create subnet in the VPC
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.subnet_name_prefix}-${terraform.workspace}"
  ip_cidr_range = local.cidr_range
  region        = var.region
  network       = google_compute_network.vpc.id
}

# Create firewall rule for SSH access
resource "google_compute_firewall" "ssh" {
  count   = var.enable_ssh ? 1 : 0
  name    = "allow-ssh-${terraform.workspace}"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = ["ssh-${terraform.workspace}"]
}

# Create firewall rule for internal communication
resource "google_compute_firewall" "internal" {
  name    = "allow-internal-${terraform.workspace}"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = [local.cidr_range]
} 