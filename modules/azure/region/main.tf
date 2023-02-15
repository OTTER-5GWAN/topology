# Create Azure VNet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.region}-region"
  location = var.region
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
  address_prefixes     = [cidrsubnet(var.ip_range, 8, 0)]  # 10.x.0.0/16 -> 10.x.0.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "default_subnet" {
  name                 = "default"
  address_prefixes     = [cidrsubnet(var.ip_range, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "azurebastion_subnet" {
  name                 = "AzureBastionSubnet"
  address_prefixes     = [cidrsubnet(var.ip_range, 10, 8)]  # 10.x.0.0/16 -> 10.x.2.0/26
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "fw_subnet" {
  address_prefixes     = [cidrsubnet(var.ip_range, 8, 3)] # 10.x.0.0/16 -> 10.x.3.0/24
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "test_subnet" {
  name= "test"
  address_prefixes     = [cidrsubnet(var.ip_range, 8, 4)]  # 10.x.0.0/16 -> 10.x.4.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_public_ip" "fw_ip" {
  allocation_method   = "Static"
  location            =  var.region
  name                = "${var.region}-FirewallPublicIP"
  resource_group_name = var.rg
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw" {
  location            = var.region
  name                = "${var.region}-Firewall"
  resource_group_name = var.rg
  sku_name            = "AZFW_VNet"
  sku_tier            = "Premium"
  firewall_policy_id  = azurerm_firewall_policy.fw_policy.id
  ip_configuration {
    name                 = "FirewallPublicIP"
    public_ip_address_id = azurerm_public_ip.fw_ip.id
    subnet_id            = azurerm_subnet.fw_subnet.id
  }
}

resource "azurerm_firewall_policy" "fw_policy" {
  location            = var.region
  name                = "${var.region}-FirewallPolicy"
  resource_group_name = var.rg
}

resource "azurerm_firewall_policy_rule_collection_group" "fw_fw_rule" {
  firewall_policy_id = azurerm_firewall_policy.fw_policy.id 
  name               = "${var.region}-DefaultNetworkRuleCollectionGroup"
  priority           = 200
  network_rule_collection {
    action   = "Allow"
    name     = "Transit"
    priority = 100
    rule {
      destination_addresses = ["10.0.0.0/8"]
      destination_ports     = ["*"]
      name                  = "PrivateTraffic"
      protocols             = ["Any"]
      source_addresses      = ["10.0.0.0/8"]
    }
  }
}

resource "azurerm_route_table" "route_table" {
  name= "${var.region}-route-table"
  location= "${var.region}"
  resource_group_name= "${var.rg}"
  disable_bgp_route_propagation = false
}

resource "azurerm_subnet_route_table_association" "route_table_assoc" {
    subnet_id = azurerm_subnet.default_subnet.id 
    route_table_id = azurerm_route_table.route_table.id
}

resource "azurerm_route_table" "route_table_fw" {
  name= "${var.region}-route-table-fw"
  location= "${var.region}"
  resource_group_name= "${var.rg}"
  disable_bgp_route_propagation = false

  route {
    name= "default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "route_table_fw_assoc" {
    subnet_id = azurerm_subnet.fw_subnet.id
    route_table_id = azurerm_route_table.route_table_fw.id
}

# Create Azure virtual network gateway
resource "azurerm_virtual_network_gateway" "gateway" {
  depends_on = [ azurerm_public_ip.gateway_ip0 ]

  name                = "${var.region}-gateway"
  resource_group_name = var.rg
  location            = var.region

  sku           = "VpnGw5"
  generation    = "Generation2"
  active_active = true

  type     = "Vpn"
  vpn_type = "RouteBased"

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

# Create a public IP addresses for the Azure VPN gateway
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


# Create local VPN gateway to represent the GCP VPN gateway interface
resource "azurerm_local_network_gateway" "local_gateway0" {
  name                = "${var.region}-lg0"
  resource_group_name = var.rg
  location            = var.region
  gateway_address     = var.gcp_gateway_ip0
  address_space       = ["10.128.0.0/10"]
  #address_space       = [var.gcp_ip_range]

}

resource "azurerm_local_network_gateway" "local_gateway1" {
  name                = "${var.region}-lg1"
  resource_group_name = var.rg
  location            = var.region
  gateway_address     = var.gcp_gateway_ip1
  address_space=["10.128.0.0/10"]
  #address_space       = [var.gcp_ip_range]

}
resource "azurerm_local_network_gateway" "local_gateway2" {
  name                = "${var.region}-lg2"
  resource_group_name = var.rg
  location            = var.region
  gateway_address     = var.gcp_gateway_ip2
  address_space=["10.128.0.0/10"]
  #address_space       = [var.gcp_ip_range]

}

resource "azurerm_local_network_gateway" "local_gateway3" {
  name                = "${var.region}-lg3"
  resource_group_name = var.rg
  location            = var.region
  gateway_address     = var.gcp_gateway_ip3
  address_space=["10.128.0.0/10"]
  #address_space       = [var.gcp_ip_range]

}

# Create inter-WAN connectivity on the Azure side (one connection per connected GCP region)
resource "azurerm_virtual_network_gateway_connection" "azure_connection0" {
  name                = "${var.region}-${var.gcp_peer_region}-connection0"
  resource_group_name = var.rg
  location            = var.region

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway0.id

  shared_key = "YOUR OWN KEY"
  enable_bgp = false
}

resource "azurerm_virtual_network_gateway_connection" "azure_connection1" {
  name                = "${var.region}-${var.gcp_peer_region}-connection1"
  resource_group_name = var.rg
  location            = var.region

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway1.id

  shared_key = "YOUR OWN KEY"
  enable_bgp = false
}
resource "azurerm_virtual_network_gateway_connection" "azure_connection2" {
  name                = "${var.region}-${var.gcp_peer_region}-connection2"
  resource_group_name = var.rg
  location            = var.region

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway2.id

  shared_key = "YOUR OWN KEY"
  enable_bgp = false
}

resource "azurerm_virtual_network_gateway_connection" "azure_connection3" {
  name                = "${var.region}-${var.gcp_peer_region}-connection3"
  resource_group_name = var.rg
  location            = var.region

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_gateway3.id

  shared_key = "YOUR OWN KEY"
  enable_bgp = false
}

# Create Bastion host (need to create a public IP address for the bastion)
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

# Create VM

# Create NIC for VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.region}-vm-nic"
  resource_group_name = var.rg
  location            = var.region
  ip_configuration {
    name                          = "${var.region}-vm-nic-config"
    subnet_id                     = azurerm_subnet.default_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_ip.id
  }
  enable_ip_forwarding = true
  enable_accelerated_networking = true
}



resource "azurerm_public_ip" "vm_ip" {
  name                = "${var.region}-vm-ip"
  resource_group_name = var.rg
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}


# Create NIC for VM
resource "azurerm_network_interface" "vm_nic1" {
  name= "${var.region}-vm-nic1"
  resource_group_name = var.rg
  location= var.region
  ip_configuration {
    name= "${var.region}-vm-nic1-config"
    subnet_id= azurerm_subnet.test_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_ip1.id
  }
  enable_ip_forwarding = true
  enable_accelerated_networking = true
}

resource "azurerm_public_ip" "vm_ip1" {
  name= "${var.region}-vm-ip1"
  resource_group_name = var.rg
  location= var.region
  allocation_method   = "Static"
  sku= "Standard"
}

# Associate NIC with NSG
resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create Azure VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.region}-vm"
  resource_group_name   = var.rg
  location              = var.region
  size                  = "Standard_E32s_v3"
  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  computer_name                   = "${var.region}-vm"
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
    name                 = "${var.region}-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb = 64
  }
}
