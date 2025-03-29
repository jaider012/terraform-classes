# The Google Cloud Project ID where resources will be created
# Replace with your actual project ID
project_id = "your-project-id"

# Default region and zone for resource creation
region = "us-central1"
zone   = "us-central1-a"

# Network configuration
# These values will be combined with workspace names for each environment
network_name       = "multi-env-network"  # Base name for VPC networks
subnet_name_prefix = "subnet"             # Prefix for subnet names
vpc_cidr           = "10.0.0.0/16"        # Main VPC CIDR block

# Security configuration
enable_ssh = true                # Enable SSH access globally
ssh_source_ranges = ["0.0.0.0/0"]  # WARNING: This allows SSH from anywhere
                                   # For production, restrict to specific IP ranges

# Instance naming
instance_name_prefix = "vm"  # Base name for compute instances 