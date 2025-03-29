output "environment" {
  description = "The current environment (workspace)"
  value       = terraform.workspace
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_cidr" {
  description = "The CIDR range of the subnet"
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

output "instance_name" {
  description = "The name of the compute instance"
  value       = google_compute_instance.vm_instance.name
}

output "instance_internal_ip" {
  description = "The internal IP address of the instance"
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "instance_external_ip" {
  description = "The external IP address of the instance"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "instance_machine_type" {
  description = "The machine type of the instance"
  value       = google_compute_instance.vm_instance.machine_type
}

output "firewall_rules" {
  description = "The names of the firewall rules"
  value       = concat(
    var.enable_ssh ? [google_compute_firewall.ssh[0].name] : [],
    [google_compute_firewall.internal.name]
  )
} 