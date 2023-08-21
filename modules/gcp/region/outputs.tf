output "ip_range" {
  description = "IP address range of this region."
  value       = var.ip_range
}

output "name_region" {
  description = "Name prefix of regional router."
  value       = var.region
}

output "gateway_ip_addr0" {
  description = "Public IP address of this region's VPN gateway."
  value       = google_compute_address.vpn_static_ip1.address
}

output "gateway_ip_addr1" {
  description = "Public IP address of this region's VPN gateway."
  value       = google_compute_address.vpn_static_ip2.address
}

output "gateway_ip_addr2" {
  description = "Public IP address of this region's VPN gateway."
  value       = google_compute_address.vpn_static_ip3.address
}

output "gateway_ip_addr3" {
  description = "Public IP address of this region's VPN gateway."
  value       = google_compute_address.vpn_static_ip4.address
}

output "public_ip" {
  description = "Public IP address of the VM in this region."
  value       = google_compute_instance.vm.network_interface.0.access_config.0.nat_ip
}

output "private_ip" {
  description = "Private IP address of the VM in this region."
  value       = google_compute_instance.vm.network_interface.0.network_ip
}

output "name_vm" {
  description = "Name of the VM in this region."
  value       = google_compute_instance.vm.name
}