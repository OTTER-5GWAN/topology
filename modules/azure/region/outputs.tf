output "gateway_ip_addr0" {
  description = "Public IP address of this region's VPN gateway."
  value       = azurerm_public_ip.gateway_ip0.ip_address
}

output "gateway_ip_addr1" {
  description = "Public IP address of this region's VPN gateway."
  value       = azurerm_public_ip.gateway_ip1.ip_address
}

output "vnet_name" {
  description = "Name of the VNet."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Full resource ID of the VNet."
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "Full resource ID of the Subnet."
  value       = azurerm_subnet.default_subnet.id
}

output "public_ip" {
  description = "Public IP address of the VM in this region."
  # getting the public_ip_address attribute from the VM doesn't work
  value = azurerm_public_ip.vm_ip.ip_address
}

output "private_ip" {
  description = "Private IP address of the VM in this region."
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "name_vm" {
  description = "Name of the VM in this region."
  value       = azurerm_linux_virtual_machine.vm.name
}