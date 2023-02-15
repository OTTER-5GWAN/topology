
output "public_ip" {
    description = "Public IP address of the VM in this region."
    # getting the public_ip_address attribute from the VM doesn't work
    value = azurerm_public_ip.vm_ip.ip_address
}

output "private_ip" {
    description = "Private IP address of the VM in this region."
    value = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "name_vm" {
    description = "Name of the VM in this region."
    value = azurerm_linux_virtual_machine.vm.name
}

