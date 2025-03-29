project_id = "your-project-id"
region     = "us-central1"
zone       = "us-central1-a"

network_name       = "multi-env-network"
subnet_name_prefix = "subnet"
vpc_cidr           = "10.0.0.0/16"

enable_ssh        = true
ssh_source_ranges = ["0.0.0.0/0"]  # Note: This is open to the world, not recommended for production

instance_name_prefix = "vm" 