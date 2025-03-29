# Create Google Compute Engine instance
resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name_prefix}-${terraform.workspace}"
  machine_type = local.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name
    
    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    environment = terraform.workspace
  }

  tags = ["ssh-${terraform.workspace}", terraform.workspace]

  metadata_startup_script = <<-SCRIPT
    #!/bin/bash
    echo "Hello from ${terraform.workspace} environment!" > /var/www/html/index.html
    SCRIPT

  # Additional settings for production environment
  dynamic "service_account" {
    for_each = terraform.workspace == "prod" ? [1] : []
    content {
      scopes = ["cloud-platform"]
    }
  }
} 