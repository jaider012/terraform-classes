# Configure the required providers and their versions
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"  # Provider source from the Terraform Registry
      version = "~> 4.0"            # Use version 4.x.x of the provider
    }
  }
  
  # Configure Google Cloud Storage as the backend for state storage
  backend "gcs" {
    bucket = "my-terraform-state-bucket"  # GCS bucket to store state
    prefix = "terraform/state"            # Path prefix within the bucket
  }
}

# Configure the Google Cloud provider with project and region
provider "google" {
  project = var.project_id  # Project ID from variables
  region  = var.region      # Region from variables
}

# Local values for environment-specific configurations
locals {
  # Get the current workspace name (dev, staging, or prod)
  env = terraform.workspace

  # Define settings specific to each environment
  # This map contains configurations that vary by environment
  environment_settings = {
    dev = {
      machine_type = "e2-small"      # Smaller, cost-effective machine for development
      cidr_range   = "10.0.1.0/24"   # CIDR range for dev environment
    }
    staging = {
      machine_type = "e2-medium"     # Medium-sized machine for testing
      cidr_range   = "10.0.2.0/24"   # CIDR range for staging environment
    }
    prod = {
      machine_type = "e2-standard-2" # Larger machine for production workloads
      cidr_range   = "10.0.3.0/24"   # CIDR range for production environment
    }
  }

  # Lookup the appropriate settings based on the current workspace
  # If the workspace isn't found in the map, use dev settings as default
  machine_type = lookup(local.environment_settings, local.env, local.environment_settings["dev"]).machine_type
  cidr_range   = lookup(local.environment_settings, local.env, local.environment_settings["dev"]).cidr_range
} 
