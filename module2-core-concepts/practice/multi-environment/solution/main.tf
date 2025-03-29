terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }

  backend "gcs" {
    bucket = "my-terraform-state-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Use local values to set environment-specific configurations
locals {
  env = terraform.workspace

  # Define settings for each environment
  environment_settings = {
    dev = {
      machine_type = "e2-small"
      cidr_range   = "10.0.1.0/24"
    }
    staging = {
      machine_type = "e2-medium"
      cidr_range   = "10.0.2.0/24"
    }
    prod = {
      machine_type = "e2-standard-2"
      cidr_range   = "10.0.3.0/24"
    }
  }

  # Use a default setting if the workspace isn't found in the map
  machine_type = lookup(local.environment_settings, local.env, local.environment_settings["dev"]).machine_type
  cidr_range   = lookup(local.environment_settings, local.env, local.environment_settings["dev"]).cidr_range
} 
