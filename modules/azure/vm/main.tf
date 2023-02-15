# Create VM

# Create NIC for VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.region}-${var.master}-app-nic"
  resource_group_name = var.rg
  location            = var.region
  ip_configuration {
    name                          = "${var.region}-${var.master}-vm-app-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_ip.id
  }
  enable_ip_forwarding = true
  enable_accelerated_networking = true
}


resource "azurerm_public_ip" "vm_ip" {
  name                = "${var.region}-${var.master}-app-ip"
  resource_group_name = var.rg
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}



# Associate NIC with NSG
resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = var.nsg_id
}

# Create Azure VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.region}-${var.master}-app-vm"
  resource_group_name   = var.rg
  location              = var.region
  size                  = var.vm_type
  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  computer_name                   = "${var.region}-${var.master}-app-vm"
  admin_username                  = "USERNAME"
  admin_password                  = "PASSWORD"
  disable_password_authentication = false


  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts" # for some reason 20.04-LTS is unavailable?
    version   = "latest"
  }

  os_disk {
    name                 = "${var.region}-${var.master}-app-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb = 64
  }
}
