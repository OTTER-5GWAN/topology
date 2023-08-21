# Create Azure VNet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.region}-region"
  location            = var.region
  address_space       = [var.ip_range]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.region}-nsg"
  location            = var.region
  resource_group_name = var.rg
}

# Create subnets
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  address_prefixes     = [cidrsubnet(var.ip_range, 8, 0)] # 10.x.0.0/16 -> 10.x.0.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "default_subnet" {
  name                 = "default"
  address_prefixes     = [cidrsubnet(var.ip_range, 8, 1)] # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "azurebastion_subnet" {
  name                 = "AzureBastionSubnet"
  address_prefixes     = [cidrsubnet(var.ip_range, 10, 8)] # 10.x.0.0/16 -> 10.x.2.0/26
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}

# Create Azure virtual network gateway
resource "azurerm_virtual_network_gateway" "gateway" {
  depends_on          = [azurerm_public_ip.gateway_ip0]
  name                = "${var.region}-gateway"
  resource_group_name = var.rg
  location            = var.region
  sku                 = "VpnGw5"
  generation          = "Generation2"
  active_active       = true
  type                = "Vpn"
  vpn_type            = "RouteBased"
  # this value defaults to `false` and everything seems to work even if it is false. But setting to true anyway...
  enable_bgp = true
  ip_configuration {
    name                 = "${var.region}-gateway-ipconfig0"
    subnet_id            = azurerm_subnet.gateway_subnet.id
    public_ip_address_id = azurerm_public_ip.gateway_ip0.id
  }
  ip_configuration {
    name                 = "${var.region}-gateway-ipconfig1"
    subnet_id            = azurerm_subnet.gateway_subnet.id
    public_ip_address_id = azurerm_public_ip.gateway_ip1.id
  }
  bgp_settings {
    asn = 65515
    peering_addresses {
      ip_configuration_name = "${var.region}-gateway-ipconfig0"
      apipa_addresses       = ["169.254.21.2"]
    }
    peering_addresses {
      ip_configuration_name = "${var.region}-gateway-ipconfig1"
      apipa_addresses       = ["169.254.22.2"]
    }
  }
}

# Create public IP addresses for the Azure VPN gateway
resource "azurerm_public_ip" "gateway_ip0" {
  name                = "${var.region}-gateway-ip0"
  resource_group_name = var.rg
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_public_ip" "gateway_ip1" {
  name                = "${var.region}-gateway-ip1"
  resource_group_name = var.rg
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create local VPN gateways to represent the GCP VPN gateway interfaces
resource "azurerm_local_network_gateway" "local_gateway0" {
  name                = "${var.region}-lg0"
  resource_group_name = var.rg
  location            = var.region
  gateway_address     = var.gcp_gateway_ip0
  address_space       = ["10.128.0.0/10"]
}

resource "azurerm_local_network_gateway" "local_gateway1" {
  name                = "${var.region}-lg1"
  resource_group_name = var.rg
  location            = var.region
  gateway_address     = var.gcp_gateway_ip1
  address_space       = ["10.128.0.0/10"]
}
resource "azurerm_local_network_gateway" "local_gateway2" {
  name                = "${var.region}-lg2"
  resource_group_name = var.rg
  location            = var.region
  gateway_address     = var.gcp_gateway_ip2
  address_space       = ["10.128.0.0/10"]
}
resource "azurerm_local_network_gateway" "local_gateway3" {
  name                = "${var.region}-lg3"
  resource_group_name = var.rg
  location            = var.region
  gateway_address     = var.gcp_gateway_ip3
  address_space       = ["10.128.0.0/10"]
}

# Create inter-WAN connectivity on the Azure side (4 connections to the connected GCP region)
resource "azurerm_virtual_network_gateway_connection" "azure_connection0" {
  name                       = "${var.region}-${var.gcp_peer_region}-connection0"
  resource_group_name        = var.rg
  location                   = var.region
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway0.id
  shared_key                 = "YOUR OWN KEY"
  enable_bgp                 = false
}
resource "azurerm_virtual_network_gateway_connection" "azure_connection1" {
  name                       = "${var.region}-${var.gcp_peer_region}-connection1"
  resource_group_name        = var.rg
  location                   = var.region
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway1.id
  shared_key                 = "YOUR OWN KEY"
  enable_bgp                 = false
}
resource "azurerm_virtual_network_gateway_connection" "azure_connection2" {
  name                       = "${var.region}-${var.gcp_peer_region}-connection2"
  resource_group_name        = var.rg
  location                   = var.region
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway2.id
  shared_key                 = "YOUR OWN KEY"
  enable_bgp                 = false
}
resource "azurerm_virtual_network_gateway_connection" "azure_connection3" {
  name                       = "${var.region}-${var.gcp_peer_region}-connection3"
  resource_group_name        = var.rg
  location                   = var.region
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway3.id
  shared_key                 = "YOUR OWN KEY"
  enable_bgp                 = false
}

# Create Bastion host
resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.region}-bastion-ip"
  resource_group_name = var.rg
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_bastion_host" "bastion" {
  name                = "${var.region}-bastion"
  resource_group_name = var.rg
  location            = var.region
  ip_configuration {
    name                 = "bastion_ipconfig"
    subnet_id            = azurerm_subnet.azurebastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}

# Info about current subscription
data "azurerm_subscription" "current" {
}

# Create VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.region}-vm-nic"
  resource_group_name = var.rg
  location            = var.region
  ip_configuration {
    name                          = "${var.region}-vm-nic-config"
    subnet_id                     = azurerm_subnet.default_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_ip.id
  }
  enable_ip_forwarding          = true
  enable_accelerated_networking = true
}
resource "azurerm_public_ip" "vm_ip" {
  name                = "${var.region}-vm-ip"
  resource_group_name = var.rg
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${var.region}-vm"
  resource_group_name             = var.rg
  location                        = var.region
  size                            = "Standard_E32s_v3"
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]
  computer_name                   = "${var.region}-vm"
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
    name                 = "${var.region}-vm-os-disk"
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