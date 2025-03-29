# Output the current workspace/environment name
# Useful for confirming which environment you're working in
output "environment" {
  description = "The current environment (workspace)"
  value       = terraform.workspace
}

# Output the unique identifier of the VPC
# This can be used by other configurations that need to reference this VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.vpc.id
}

# Output the name of the VPC
# Useful for human-readable reference and debugging
output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

# Output the unique identifier of the subnet
# Can be used by other resources that need to be placed in this subnet
output "subnet_id" {
  description = "The ID of the subnet"
  value       = google_compute_subnetwork.subnet.id
}

# Output the CIDR range of the subnet
# Useful for confirming the network range and for network planning
output "subnet_cidr" {
  description = "The CIDR range of the subnet"
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

# Output the name of the compute instance
# Helpful for identifying the instance in the GCP console
output "instance_name" {
  description = "The name of the compute instance"
  value       = google_compute_instance.vm_instance.name
}

# Output the internal IP address of the instance
# Used for internal network communication
output "instance_internal_ip" {
  description = "The internal IP address of the instance"
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}

# Output the external IP address of the instance
# Used for external access to the instance
output "instance_external_ip" {
  description = "The external IP address of the instance"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

# Output the machine type of the instance
# Useful for confirming the correct size is used in each environment
output "instance_machine_type" {
  description = "The machine type of the instance"
  value       = google_compute_instance.vm_instance.machine_type
}

# Output the names of all firewall rules created
# Combines SSH rules (if enabled) and internal communication rules
output "firewall_rules" {
  description = "The names of the firewall rules"
  value       = concat(
    # Include SSH firewall rule name only if SSH is enabled
    var.enable_ssh ? [google_compute_firewall.ssh[0].name] : [],
    # Always include the internal firewall rule name
    [google_compute_firewall.internal.name]
  )
} 