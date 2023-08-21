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
    public_ip_address_id          = azurerm_public_ip.vm_ip.id
  }
  enable_ip_forwarding          = true
  enable_accelerated_networking = true
}

# Create public IP address for VM
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

# Info about current subscription
data "azurerm_subscription" "current" {
}

# Create Azure VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${var.region}-${var.master}-app-vm"
  resource_group_name             = var.rg
  location                        = var.region
  size                            = var.vm_type
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]
  computer_name                   = "${var.region}-${var.master}-app-vm"
  admin_username                  = "USERNAME"
  admin_password                  = "PASSWORD"
  disable_password_authentication = false

  # pick image from this command:
  # az vm image list --architecture x64 --offer ubuntu-server --publisher Canonical --sku lts --all --output table
  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.region}-${var.master}-app-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }

  # Azure security junk
  tags = {
    "azsecpack"                                                                = "nonprod"
    "platformsettings.host_environment.service.platform_optedin_for_rootcerts" = true
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [
      "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/AzSecPackAutoConfigRG/providers/Microsoft.ManagedIdentity/userAssignedIdentities/AzSecPackAutoConfigUA-${var.region}"
    ]
  }
}