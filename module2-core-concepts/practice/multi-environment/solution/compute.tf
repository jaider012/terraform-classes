# Create a Google Compute Engine virtual machine instance
# This instance will be customized based on the current workspace environment
resource "google_compute_instance" "vm_instance" {
  # Name combines the instance prefix with the current workspace
  name = "${var.instance_name_prefix}-${terraform.workspace}"
  
  # Machine type is determined by the environment (dev/staging/prod)
  machine_type = local.machine_type
  
  # Zone where the instance will be created
  zone = var.zone

  # Configure the boot disk with Debian 11
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Use Debian 11 as the base OS
    }
  }

  # Configure the network interfaces
  network_interface {
    # Connect to the VPC network we created
    network = google_compute_network.vpc.name
    
    # Connect to the subnet for this environment
    subnetwork = google_compute_subnetwork.subnet.name
    
    # Configure external IP access
    access_config {
      // Ephemeral IP - an external IP will be automatically assigned
    }
  }

  # Add metadata to identify the environment
  metadata = {
    environment = terraform.workspace
  }

  # Add network tags for firewall rules
  # The SSH tag allows SSH access if enabled
  tags = ["ssh-${terraform.workspace}", terraform.workspace]

  # Simple startup script to demonstrate environment-specific configuration
  metadata_startup_script = <<-SCRIPT
    #!/bin/bash
    echo "Hello from ${terraform.workspace} environment!" > /var/www/html/index.html
    SCRIPT

  # Additional settings specific to production environment
  # This demonstrates conditional configuration based on the workspace
  dynamic "service_account" {
    # Only create service account for production environment
    for_each = terraform.workspace == "prod" ? [1] : []
    content {
      # Grant cloud-platform scope for production workloads
      scopes = ["cloud-platform"]
    }
  }
} 