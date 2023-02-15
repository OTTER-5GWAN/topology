# Create Azure VNet
resource "azurerm_virtual_network" "vnet8" {
  name                = "${var.region}-app-region8"
  location            = var.region8
  address_space       = [var.ip_range8]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg8" {
  name                = "${var.region}-app-nsg8"
  location            = var.region8
  resource_group_name = var.rg
}

resource "azurerm_subnet" "default_subnet8" {
  name                 = "default8"
  address_prefixes     = [cidrsubnet(var.ip_range8, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet8.name
}


resource "azurerm_virtual_network" "vnet7" {
  name                = "${var.region}-app-region7"
  location            = var.region7
  address_space       = [var.ip_range7]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg7" {
  name                = "${var.region}-app-nsg7"
  location            = var.region7
  resource_group_name = var.rg
}

resource "azurerm_subnet" "default_subnet7" {
  name                 = "default7"
  address_prefixes     = [cidrsubnet(var.ip_range7, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet7.name
}


resource "azurerm_virtual_network" "vnet6" {
  name                = "${var.region}-app-region6"
  location            = var.region6
  address_space       = [var.ip_range6]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg6" {
  name                = "${var.region}-app-nsg6"
  location            = var.region6
  resource_group_name = var.rg
}

resource "azurerm_subnet" "default_subnet6" {
  name                 = "default6"
  address_prefixes     = [cidrsubnet(var.ip_range6, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet6.name
}


resource "azurerm_virtual_network" "vnet5" {
  name                = "${var.region}-app-region5"
  location            = var.region5
  address_space       = [var.ip_range5]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg5" {
  name                = "${var.region}-app-nsg5"
  location            = var.region5
  resource_group_name = var.rg
}

resource "azurerm_subnet" "default_subnet5" {
  name                 = "default5"
  address_prefixes     = [cidrsubnet(var.ip_range5, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet5.name
}


resource "azurerm_virtual_network" "vnet4" {
  name                = "${var.region}-app-region4"
  location            = var.region4
  address_space       = [var.ip_range4]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg4" {
  name                = "${var.region}-app-nsg4"
  location            = var.region4
  resource_group_name = var.rg
}

resource "azurerm_subnet" "default_subnet4" {
  name                 = "default4"
  address_prefixes     = [cidrsubnet(var.ip_range4, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet4.name
}



resource "azurerm_virtual_network" "vnet3" {
  name                = "${var.region}-app-region3"
  location            = var.region3
  address_space       = [var.ip_range3]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg3" {
  name                = "${var.region}-app-nsg3"
  location            = var.region3
  resource_group_name = var.rg
}

resource "azurerm_subnet" "default_subnet3" {
  name                 = "default3"
  address_prefixes     = [cidrsubnet(var.ip_range3, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet3.name
}


resource "azurerm_virtual_network" "vnet2" {
  name                = "${var.region}-app-region2"
  location            = var.region2
  address_space       = [var.ip_range2]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg2" {
  name                = "${var.region}-app-nsg2"
  location            = var.region2
  resource_group_name = var.rg
}

resource "azurerm_subnet" "default_subnet2" {
  name                 = "default2"
  address_prefixes     = [cidrsubnet(var.ip_range2, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet2.name
}



resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.region}-app-region1"
  location            = var.region1
  address_space       = [var.ip_range1]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg1" {
  name                = "${var.region}-app-nsg1"
  location            = var.region1
  resource_group_name = var.rg
}

resource "azurerm_subnet" "default_subnet1" {
  name                 = "default1"
  address_prefixes     = [cidrsubnet(var.ip_range1, 8, 1)]  # 10.x.0.0/16 -> 10.x.1.0/24
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet1.name
}


resource "azurerm_virtual_network" "vnet" {
  name                = "${var.region}-app-region"
  location = var.region
  address_space       = [var.ip_range]
  resource_group_name = var.rg
}

# Create NSG to associate with VMs. Defaults will include DenyAllInBound
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.region}-app-nsg"
  location            = var.region
  resource_group_name = var.rg
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


# Create Bastion host (need to create a public IP address for the bastion)
resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.region}-bastion-app-ip"
  resource_group_name = var.rg
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "${var.region}-app-bastion"
  resource_group_name = var.rg
  location            = var.region
  ip_configuration {
    name                 = "bastion_ipconfig"
    subnet_id            = azurerm_subnet.azurebastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}

