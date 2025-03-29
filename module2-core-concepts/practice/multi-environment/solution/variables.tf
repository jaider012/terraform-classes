# Required: The Google Cloud Project ID
# This variable has no default and must be provided
variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

# The region where resources will be created
# Defaults to us-central1 if not specified
variable "region" {
  description = "The region to deploy resources into"
  type        = string
  default     = "us-central1"
}

# The zone within the region for zone-specific resources
# Defaults to us-central1-a if not specified
variable "zone" {
  description = "The zone to deploy resources into"
  type        = string
  default     = "us-central1-a"
}

# The name of the VPC network to create
# Will be combined with workspace name for environment-specific networks
variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "terraform-network"
}

# Prefix for subnet names
# Will be combined with workspace name for environment-specific subnets
variable "subnet_name_prefix" {
  description = "The prefix for subnet names"
  type        = string
  default     = "subnet"
}

# The main CIDR block for the VPC
# This is the overall network range that will be subdivided
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Boolean flag to enable/disable SSH access
# Can be used to quickly disable SSH access in certain environments
variable "enable_ssh" {
  description = "Whether to enable SSH access"
  type        = bool
  default     = true
}

# List of CIDR ranges that can access instances via SSH
# WARNING: The default is open to the world and should be restricted in production
variable "ssh_source_ranges" {
  description = "Source IP address ranges for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Note: This is open to the world, not recommended for production
}

# Prefix for instance names
# Will be combined with workspace name for environment-specific instances
variable "instance_name_prefix" {
  description = "Prefix for instance names"
  type        = string
  default     = "vm"
} 