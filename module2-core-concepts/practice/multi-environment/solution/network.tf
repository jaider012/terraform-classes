# Create a Virtual Private Cloud (VPC) network
# This is the main network where all resources will be deployed
resource "google_compute_network" "vpc" {
  # Name combines the base network name with the current workspace
  name = "${var.network_name}-${terraform.workspace}"
  
  # Disable automatic subnet creation - we'll create them explicitly
  auto_create_subnetworks = false
}

# Create a subnet within the VPC
# Each environment (workspace) gets its own subnet with a unique CIDR range
resource "google_compute_subnetwork" "subnet" {
  # Name combines the subnet prefix with the current workspace
  name = "${var.subnet_name_prefix}-${terraform.workspace}"
  
  # Use the CIDR range defined in locals based on the environment
  ip_cidr_range = local.cidr_range
  
  # Region where the subnet will be created
  region = var.region
  
  # Reference to the parent VPC network
  network = google_compute_network.vpc.id
}

# Create a firewall rule to allow SSH access
# This is conditionally created based on the enable_ssh variable
resource "google_compute_firewall" "ssh" {
  # Only create this rule if SSH is enabled
  count = var.enable_ssh ? 1 : 0
  
  # Name includes the workspace to make it environment-specific
  name = "allow-ssh-${terraform.workspace}"
  
  # Reference to the VPC network where this rule applies
  network = google_compute_network.vpc.name

  # Allow incoming TCP traffic on port 22 (SSH)
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Source IP ranges that are allowed to connect via SSH
  source_ranges = var.ssh_source_ranges
  
  # Apply this rule only to instances with the SSH tag
  target_tags = ["ssh-${terraform.workspace}"]
}

# Create a firewall rule for internal network communication
# This allows all internal traffic within the subnet
resource "google_compute_firewall" "internal" {
  # Name includes the workspace to make it environment-specific
  name = "allow-internal-${terraform.workspace}"
  
  # Reference to the VPC network where this rule applies
  network = google_compute_network.vpc.name

  # Allow all ICMP traffic (ping, etc.)
  allow {
    protocol = "icmp"
  }

  # Allow all TCP ports for internal communication
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  # Allow all UDP ports for internal communication
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  # Only allow traffic from within the subnet's CIDR range
  source_ranges = [local.cidr_range]
} 