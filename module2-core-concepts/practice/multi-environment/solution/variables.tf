variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources into"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to deploy resources into"
  type        = string
  default     = "us-central1-a"
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "terraform-network"
}

variable "subnet_name_prefix" {
  description = "The prefix for subnet names"
  type        = string
  default     = "subnet"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_ssh" {
  description = "Whether to enable SSH access"
  type        = bool
  default     = true
}

variable "ssh_source_ranges" {
  description = "Source IP address ranges for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Note: This is open to the world, not recommended for production
}

variable "instance_name_prefix" {
  description = "Prefix for instance names"
  type        = string
  default     = "vm"
} 