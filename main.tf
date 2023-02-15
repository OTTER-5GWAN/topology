terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.9.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">=4.23.0"
    }
  }
}

# Azure WAN: 10.64.0.0/10 (10.64.0.1 - 10.127.255.254)
# GCP WAN: 10.128.0.0/10 (10.128.0.1 - 10.191.255.254)


resource "google_compute_network" "terra_vpc" {
  name                    = "tf-us-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  mtu                     = 1460
}

module "gcp_firewall" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

module "gcp_firewall1" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc1.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

module "gcp_firewall2" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc2.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

module "gcp_firewall3" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc3.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

module "gcp_firewall4" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc4.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

module "gcp_firewall5" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc5.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

module "gcp_firewall6" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc6.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

module "gcp_firewall7" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc7.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

module "gcp_firewall8" {
  source = "./modules/gcp/firewall"
  vpc    = google_compute_network.terra_vpc8.name
  # allow GCP traffic to reach GCP servers
  gcp_ips = ["10.128.0.0/10"]
  # allow Azure traffic to reach GCP servers
  azure_ips = ["10.64.0.0/10"]
}

# Deploy all resources in the Azure WAN in this resource group
resource "azurerm_resource_group" "terra_rg" {
  name     = "tf-us-rg"
  location = "westus3" # location of RG not relevant
}


// ----------------------------------------

resource "google_compute_network" "terra_vpc1" {
  name= "tf-us-vpc1"
  auto_create_subnetworks = false
  routing_mode= "GLOBAL"
  mtu= 1460
}

module "gcp_us_central1_region" {
  source   = "./modules/gcp/region"
  vpc      = google_compute_network.terra_vpc1.name
  region   = "us-central1"
  ip_range = "10.128.0.0/16"
  sec_ip_range = "10.140.0.0/16"

  # one per tunnel connection
  azure_peer_region = "centralus"
  azure_gateway_ip0 = module.azure_centralus_region.gateway_ip_addr0
  azure_gateway_ip1 = module.azure_centralus_region.gateway_ip_addr1 
  azure_ip_range = "10.64.0.0/16"
  azure_app_ip_range = "10.91.0.0/16"
}
module "azure_centralus_region" {
  source   = "./modules/azure/region"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "centralus"
  ip_range = "10.64.0.0/16"

  # one per tunnel connection
  gcp_peer_region        = "us-central1"
  gcp_ip_range           = module.gcp_us_central1_region.ip_range
  gcp_gateway_ip0        = module.gcp_us_central1_region.gateway_ip_addr0
  gcp_gateway_ip1        = module.gcp_us_central1_region.gateway_ip_addr1
  gcp_gateway_ip2        = module.gcp_us_central1_region.gateway_ip_addr2
  gcp_gateway_ip3        = module.gcp_us_central1_region.gateway_ip_addr3

}

module "azure_centralus_app_region" {
  source   = "./modules/azure/app"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "centralus"
  ip_range = "10.81.0.0/16"
  region1   = "centralus"
  ip_range1 = "10.91.0.0/20"
  region2   = "eastus"
  ip_range2 = "10.91.16.0/20"
  region3   = "eastus2"
  ip_range3 = "10.91.32.0/20"
  region4   = "northcentralus"
  ip_range4 = "10.91.48.0/20"
  region5   = "southcentralus"
  ip_range5 = "10.91.64.0/20"
  region6   = "westcentralus"
  ip_range6 = "10.91.80.0/20"
  region7   = "westus"
  ip_range7 = "10.91.96.0/20"
  region8   = "westus3"
  ip_range8 = "10.91.112.0/20"
}

// ----------------------------------------

resource "google_compute_network" "terra_vpc2" {
  name= "tf-us-vpc2"
  auto_create_subnetworks = false
  routing_mode= "GLOBAL"
  mtu= 1460
}

module "gcp_us_east1_region" {
  source   = "./modules/gcp/region"
  vpc      = google_compute_network.terra_vpc2.name
  region   = "us-east1"
  ip_range = "10.129.0.0/16"
  sec_ip_range="10.141.0.0/16"

  # one per tunnel connection
  azure_peer_region = "eastus"
  azure_gateway_ip0 = module.azure_eastus_region.gateway_ip_addr0
  azure_gateway_ip1 = module.azure_eastus_region.gateway_ip_addr1
  azure_ip_range="10.65.0.0/16"
  azure_app_ip_range="10.92.0.0/16"
}
module "azure_eastus_region" {
  source   = "./modules/azure/region"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "eastus"
  ip_range = "10.65.0.0/16"

  # one per tunnel connection
  gcp_peer_region        = "us-east1"
  gcp_ip_range           = module.gcp_us_east1_region.ip_range
  gcp_gateway_ip0        = module.gcp_us_east1_region.gateway_ip_addr0
  gcp_gateway_ip1        = module.gcp_us_east1_region.gateway_ip_addr1
  gcp_gateway_ip2        = module.gcp_us_east1_region.gateway_ip_addr2
  gcp_gateway_ip3        = module.gcp_us_east1_region.gateway_ip_addr3

}

module "azure_eastus_app_region" {
  source   = "./modules/azure/app"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "eastus"
  ip_range = "10.82.0.0/16"
  region1   = "centralus"
  ip_range1 = "10.92.0.0/20"
  region2   = "eastus"
  ip_range2 = "10.92.16.0/20"
  region3   = "eastus2"
  ip_range3 = "10.92.32.0/20"
  region4   = "northcentralus"
  ip_range4 = "10.92.48.0/20"
  region5   = "southcentralus"
  ip_range5 = "10.92.64.0/20"
  region6   = "westcentralus"
  ip_range6 = "10.92.80.0/20"
  region7   = "westus"
  ip_range7 = "10.92.96.0/20"
  region8   = "westus3"
  ip_range8 = "10.92.112.0/20"
}

// ----------------------------------------

resource "google_compute_network" "terra_vpc3" {
  name= "tf-us-vpc3"
  auto_create_subnetworks = false
  routing_mode= "GLOBAL"
  mtu= 1460
}

module "gcp_us_east4_region" {
  source   = "./modules/gcp/region"
  vpc      = google_compute_network.terra_vpc3.name
  region   = "us-east4"
  ip_range = "10.130.0.0/16"
  sec_ip_range="10.142.0.0/16"

  # one per tunnel connection
  azure_peer_region = "eastus2"
  azure_gateway_ip0 = module.azure_eastus2_region.gateway_ip_addr0
  azure_gateway_ip1 = module.azure_eastus2_region.gateway_ip_addr1
  azure_ip_range="10.66.0.0/16"
  azure_app_ip_range="10.93.0.0/16"
}
module "azure_eastus2_region" {
  source   = "./modules/azure/region"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  ip_range = "10.66.0.0/16"

  # one per tunnel connection
  gcp_peer_region        = "us-east4"
  gcp_ip_range           = module.gcp_us_east4_region.ip_range
  gcp_gateway_ip0        = module.gcp_us_east4_region.gateway_ip_addr0
  gcp_gateway_ip1        = module.gcp_us_east4_region.gateway_ip_addr1
  gcp_gateway_ip2        = module.gcp_us_east4_region.gateway_ip_addr2
  gcp_gateway_ip3        = module.gcp_us_east4_region.gateway_ip_addr3
}

module "azure_eastus2_app_region" {
  source   = "./modules/azure/app"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  ip_range = "10.83.0.0/16"
  region1   = "centralus"
  ip_range1 = "10.93.0.0/20"
  region2   = "eastus"
  ip_range2 = "10.93.16.0/20"
  region3   = "eastus2"
  ip_range3 = "10.93.32.0/20"
  region4   = "northcentralus"
  ip_range4 = "10.93.48.0/20"
  region5   = "southcentralus"
  ip_range5 = "10.93.64.0/20"
  region6   = "westcentralus"
  ip_range6 = "10.93.80.0/20"
  region7   = "westus"
  ip_range7 = "10.93.96.0/20"
  region8   = "westus3"
  ip_range8 = "10.93.112.0/20"

}
// ----------------------------------------

resource "google_compute_network" "terra_vpc4" {
  name= "tf-us-vpc4"
  auto_create_subnetworks = false
  routing_mode= "GLOBAL"
  mtu= 1460
}

module "gcp_us_east5_region" {
  source   = "./modules/gcp/region"
  vpc      = google_compute_network.terra_vpc4.name
  region   = "us-east5"
  ip_range = "10.131.0.0/16"
  sec_ip_range="10.143.0.0/16"

  # one per tunnel connection
  azure_peer_region = "northcentralus"
  azure_gateway_ip0 = module.azure_northcentralus_region.gateway_ip_addr0
  azure_gateway_ip1 = module.azure_northcentralus_region.gateway_ip_addr1
  azure_ip_range="10.67.0.0/16"
  azure_app_ip_range="10.94.0.0/16"
}
module "azure_northcentralus_region" {
  source   = "./modules/azure/region"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  ip_range = "10.67.0.0/16"

  # one per tunnel connection
  gcp_peer_region        = "us-east5"
  gcp_ip_range           = module.gcp_us_east5_region.ip_range
  gcp_gateway_ip0        = module.gcp_us_east5_region.gateway_ip_addr0
  gcp_gateway_ip1        = module.gcp_us_east5_region.gateway_ip_addr1
  gcp_gateway_ip2        = module.gcp_us_east5_region.gateway_ip_addr2
  gcp_gateway_ip3        = module.gcp_us_east5_region.gateway_ip_addr3
}

module "azure_northcentralus_app_region" {
  source   = "./modules/azure/app"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  ip_range = "10.84.0.0/16"
  region1   = "centralus"
  ip_range1 = "10.94.0.0/20"
  region2   = "eastus"
  ip_range2 = "10.94.16.0/20"
  region3   = "eastus2"
  ip_range3 = "10.94.32.0/20"
  region4   = "northcentralus"
  ip_range4 = "10.94.48.0/20"
  region5   = "southcentralus"
  ip_range5 = "10.94.64.0/20"
  region6   = "westcentralus"
  ip_range6 = "10.94.80.0/20"
  region7   = "westus"
  ip_range7 = "10.94.96.0/20"
  region8   = "westus3"
  ip_range8 = "10.94.112.0/20"

}
// ----------------------------------------

resource "google_compute_network" "terra_vpc5" {
  name= "tf-us-vpc5"
  auto_create_subnetworks = false
  routing_mode= "GLOBAL"
  mtu= 1460
}

module "gcp_us_south1_region" {
  source   = "./modules/gcp/region"
  vpc      = google_compute_network.terra_vpc5.name
  region   = "us-south1"
  ip_range = "10.132.0.0/16"
  sec_ip_range="10.144.0.0/16"

  # one per tunnel connection
  azure_peer_region = "southcentralus"
  azure_gateway_ip0 = module.azure_southcentralus_region.gateway_ip_addr0
  azure_gateway_ip1 = module.azure_southcentralus_region.gateway_ip_addr1
  azure_ip_range="10.68.0.0/16"
  azure_app_ip_range="10.95.0.0/16"
}
module "azure_southcentralus_region" {
  source   = "./modules/azure/region"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  ip_range = "10.68.0.0/16"

  # one per tunnel connection
  gcp_peer_region        = "us-south1"
  gcp_ip_range           = module.gcp_us_south1_region.ip_range
  gcp_gateway_ip0        = module.gcp_us_south1_region.gateway_ip_addr0
  gcp_gateway_ip1        = module.gcp_us_south1_region.gateway_ip_addr1
  gcp_gateway_ip2        = module.gcp_us_south1_region.gateway_ip_addr2
  gcp_gateway_ip3        = module.gcp_us_south1_region.gateway_ip_addr3


}

module "azure_southcentralus_app_region" {
  source   = "./modules/azure/app"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  ip_range = "10.85.0.0/16"
  region1   = "centralus"
  ip_range1 = "10.95.0.0/20"
  region2   = "eastus"
  ip_range2 = "10.95.16.0/20"
  region3   = "eastus2"
  ip_range3 = "10.95.32.0/20"
  region4   = "northcentralus"
  ip_range4 = "10.95.48.0/20"
  region5   = "southcentralus"
  ip_range5 = "10.95.64.0/20"
  region6   = "westcentralus"
  ip_range6 = "10.95.80.0/20"
  region7   = "westus"
  ip_range7 = "10.95.96.0/20"
  region8   = "westus3"
  ip_range8 = "10.95.112.0/20"

}
// ----------------------------------------

resource "google_compute_network" "terra_vpc6" {
  name= "tf-us-vpc6"
  auto_create_subnetworks = false
  routing_mode= "GLOBAL"
  mtu= 1460
}

module "gcp_us_west3_region" {
  source   = "./modules/gcp/region"
  vpc      = google_compute_network.terra_vpc6.name
  region   = "us-west3"
  ip_range = "10.133.0.0/16"
  sec_ip_range="10.145.0.0/16"

  # one per tunnel connection
  azure_peer_region = "westcentralus"
  azure_gateway_ip0 = module.azure_westcentralus_region.gateway_ip_addr0
  azure_gateway_ip1 = module.azure_westcentralus_region.gateway_ip_addr1
  azure_ip_range="10.69.0.0/16"
  azure_app_ip_range="10.96.0.0/16"
}
module "azure_westcentralus_region" {
  source   = "./modules/azure/region"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  ip_range = "10.69.0.0/16"

  # one per tunnel connection
  gcp_peer_region        = "us-west3"
  gcp_ip_range           = module.gcp_us_west3_region.ip_range
  gcp_gateway_ip0        = module.gcp_us_west3_region.gateway_ip_addr0
  gcp_gateway_ip1        = module.gcp_us_west3_region.gateway_ip_addr1
  gcp_gateway_ip2        = module.gcp_us_west3_region.gateway_ip_addr2
  gcp_gateway_ip3        = module.gcp_us_west3_region.gateway_ip_addr3


}

module "azure_westcentralus_app_region" {
  source   = "./modules/azure/app"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  ip_range = "10.86.0.0/16"
  region1   = "centralus"
  ip_range1 = "10.96.0.0/20"
  region2   = "eastus"
  ip_range2 = "10.96.16.0/20"
  region3   = "eastus2"
  ip_range3 = "10.96.32.0/20"
  region4   = "northcentralus"
  ip_range4 = "10.96.48.0/20"
  region5   = "southcentralus"
  ip_range5 = "10.96.64.0/20"
  region6   = "westcentralus"
  ip_range6 = "10.96.80.0/20"
  region7   = "westus"
  ip_range7 = "10.96.96.0/20"
  region8   = "westus3"
  ip_range8 = "10.96.112.0/20"

}
// ----------------------------------------

resource "google_compute_network" "terra_vpc7" {
  name= "tf-us-vpc7"
  auto_create_subnetworks = false
  routing_mode= "GLOBAL"
  mtu= 1460
}

module "gcp_us_west2_region" {
  source   = "./modules/gcp/region"
  vpc      = google_compute_network.terra_vpc7.name
  region   = "us-west2"
  ip_range = "10.134.0.0/16"
  sec_ip_range="10.146.0.0/16"

  # one per tunnel connection
  azure_peer_region = "westus"
  azure_gateway_ip0 = module.azure_westus_region.gateway_ip_addr0
  azure_gateway_ip1 = module.azure_westus_region.gateway_ip_addr1
  azure_ip_range="10.70.0.0/16"
  azure_app_ip_range="10.97.0.0/16"
}
module "azure_westus_region" {
  source   = "./modules/azure/region"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "westus"
  ip_range = "10.70.0.0/16"

  # one per tunnel connection
  gcp_peer_region        = "us-west2"
  gcp_ip_range           = module.gcp_us_west2_region.ip_range
  gcp_gateway_ip0        = module.gcp_us_west2_region.gateway_ip_addr0
  gcp_gateway_ip1        = module.gcp_us_west2_region.gateway_ip_addr1
  gcp_gateway_ip2        = module.gcp_us_west2_region.gateway_ip_addr2
  gcp_gateway_ip3        = module.gcp_us_west2_region.gateway_ip_addr3


}

module "azure_westus_app_region" {
  source   = "./modules/azure/app"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "westus"
  ip_range = "10.87.0.0/16"
  region1   = "centralus"
  ip_range1 = "10.97.0.0/20"
  region2   = "eastus"
  ip_range2 = "10.97.16.0/20"
  region3   = "eastus2"
  ip_range3 = "10.97.32.0/20"
  region4   = "northcentralus"
  ip_range4 = "10.97.48.0/20"
  region5   = "southcentralus"
  ip_range5 = "10.97.64.0/20"
  region6   = "westcentralus"
  ip_range6 = "10.97.80.0/20"
  region7   = "westus"
  ip_range7 = "10.97.96.0/20"
  region8   = "westus3"
  ip_range8 = "10.97.112.0/20"

}

resource "google_compute_network" "terra_vpc8" {
  name= "tf-us-vpc8"
  auto_create_subnetworks = false
  routing_mode= "GLOBAL"
  mtu= 1460
}

module "gcp_us_west4_region" {
  source   = "./modules/gcp/region"
  vpc      = google_compute_network.terra_vpc8.name
  region   = "us-west4"
  ip_range = "10.136.0.0/16"
  sec_ip_range="10.148.0.0/16"

  # one per tunnel connection
  azure_peer_region = "westus3"
  azure_gateway_ip0 = module.azure_westus3_region.gateway_ip_addr0
  azure_gateway_ip1 = module.azure_westus3_region.gateway_ip_addr1
  azure_ip_range="10.72.0.0/16"
  azure_app_ip_range="10.98.0.0/16"
}
module "azure_westus3_region" {
  source   = "./modules/azure/region"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "westus3"
  ip_range = "10.72.0.0/16"

  # one per tunnel connection
  gcp_peer_region        = "us-west4"
  gcp_ip_range           = module.gcp_us_west4_region.ip_range
  gcp_gateway_ip0        = module.gcp_us_west4_region.gateway_ip_addr0
  gcp_gateway_ip1        = module.gcp_us_west4_region.gateway_ip_addr1
  gcp_gateway_ip2        = module.gcp_us_west4_region.gateway_ip_addr2
  gcp_gateway_ip3        = module.gcp_us_west4_region.gateway_ip_addr3


}

module "azure_westus3_app_region" {
  source   = "./modules/azure/app"
  rg       = azurerm_resource_group.terra_rg.name
  region   = "westus3"
  ip_range = "10.88.0.0/16"
  region1   = "centralus"
  ip_range1 = "10.98.0.0/20"
  region2   = "eastus"
  ip_range2 = "10.98.16.0/20"
  region3   = "eastus2"
  ip_range3 = "10.98.32.0/20"
  region4   = "northcentralus"
  ip_range4 = "10.98.48.0/20"
  region5   = "southcentralus"
  ip_range5 = "10.98.64.0/20"
  region6   = "westcentralus"
  ip_range6 = "10.98.80.0/20"
  region7   = "westus"
  ip_range7 = "10.98.96.0/20"
  region8   = "westus3"
  ip_range8 = "10.98.112.0/20"

}
module "azure_centralus_app_vm1" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "centralus"
  subnet_id = module.azure_centralus_app_region.subnet_id1
  nsg_id = module.azure_centralus_app_region.nsg_id1
  master = "centralus"
  vm_type="Standard_D32s_v3"
}

module "azure_centralus_app_vm2" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus"
  subnet_id = module.azure_centralus_app_region.subnet_id2
  nsg_id = module.azure_centralus_app_region.nsg_id2
  master="centralus"
  vm_type = "Standard_E32s_v3"
}
module "azure_centralus_app_vm3" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  subnet_id = module.azure_centralus_app_region.subnet_id3
  nsg_id = module.azure_centralus_app_region.nsg_id3
  master="centralus"
  vm_type="Standard_E32s_v3"
}
module "azure_centralus_app_vm4" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  subnet_id = module.azure_centralus_app_region.subnet_id4
  nsg_id = module.azure_centralus_app_region.nsg_id4
  master="centralus"
  vm_type="Standard_D32s_v3"
}
module "azure_centralus_app_vm5" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  subnet_id = module.azure_centralus_app_region.subnet_id5
  nsg_id = module.azure_centralus_app_region.nsg_id5
  master="centralus"
  vm_type="Standard_E32s_v3"
}
module "azure_centralus_app_vm6" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  subnet_id = module.azure_centralus_app_region.subnet_id6
  nsg_id = module.azure_centralus_app_region.nsg_id6
  master="centralus"
  vm_type="Standard_D32s_v3"
}
module "azure_centralus_app_vm7" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus"
  subnet_id = module.azure_centralus_app_region.subnet_id7
  nsg_id = module.azure_centralus_app_region.nsg_id7
  master="centralus"
  vm_type="Standard_D32s_v4"
}
module "azure_centralus_app_vm8" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus3"
  subnet_id = module.azure_centralus_app_region.subnet_id8
  nsg_id = module.azure_centralus_app_region.nsg_id8
  master="centralus"
  vm_type="Standard_D32s_v3"
}

module "azure_eastus_app_vm1" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "centralus"
  subnet_id = module.azure_eastus_app_region.subnet_id1
  nsg_id = module.azure_eastus_app_region.nsg_id1
  master="eastus"
  vm_type="Standard_D32s_v3"
}
module "azure_eastus_app_vm2" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus"
  subnet_id = module.azure_eastus_app_region.subnet_id2
  nsg_id = module.azure_eastus_app_region.nsg_id2
  master="eastus"
  vm_type="Standard_E32s_v3"
}
module "azure_eastus_app_vm3" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  subnet_id = module.azure_eastus_app_region.subnet_id3
  nsg_id = module.azure_eastus_app_region.nsg_id3
  master="eastus"
  vm_type="Standard_E32s_v3"
}
module "azure_eastus_app_vm4" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  subnet_id = module.azure_eastus_app_region.subnet_id4
  nsg_id = module.azure_eastus_app_region.nsg_id4
  master="eastus"
  vm_type="Standard_D32s_v3"
}
module "azure_eastus_app_vm5" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  subnet_id = module.azure_eastus_app_region.subnet_id5
  nsg_id = module.azure_eastus_app_region.nsg_id5
  master="eastus"
  vm_type="Standard_E32s_v3"
}
module "azure_eastus_app_vm6" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  subnet_id = module.azure_eastus_app_region.subnet_id6
  nsg_id = module.azure_eastus_app_region.nsg_id6
  master="eastus"
  vm_type="Standard_D32s_v3"
}
module "azure_eastus_app_vm7" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus"
  subnet_id = module.azure_eastus_app_region.subnet_id7
  nsg_id = module.azure_eastus_app_region.nsg_id7
  master="eastus"
  vm_type="Standard_D32s_v4"
}
module "azure_eastus_app_vm8" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus3"
  subnet_id = module.azure_eastus_app_region.subnet_id8
  nsg_id = module.azure_eastus_app_region.nsg_id8
  master="eastus"
  vm_type="Standard_D32s_v3"
}

module "azure_eastus2_app_vm1" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "centralus"
  subnet_id = module.azure_eastus2_app_region.subnet_id1
  nsg_id = module.azure_eastus2_app_region.nsg_id1
  master="eastus2"
  vm_type="Standard_D32s_v3"
}
module "azure_eastus2_app_vm2" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus"
  subnet_id = module.azure_eastus2_app_region.subnet_id2
  nsg_id = module.azure_eastus2_app_region.nsg_id2
  master="eastus2"
  vm_type="Standard_E32s_v3"
}
module "azure_eastus2_app_vm3" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  subnet_id = module.azure_eastus2_app_region.subnet_id3
  nsg_id = module.azure_eastus2_app_region.nsg_id3
  master="eastus2"
  vm_type="Standard_E32s_v3"
}
module "azure_eastus2_app_vm4" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  subnet_id = module.azure_eastus2_app_region.subnet_id4
  nsg_id = module.azure_eastus2_app_region.nsg_id4
  master="eastus2"
  vm_type="Standard_D32s_v3"
}
module "azure_eastus2_app_vm5" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  subnet_id = module.azure_eastus2_app_region.subnet_id5
  nsg_id = module.azure_eastus2_app_region.nsg_id5
  master="eastus2"
  vm_type="Standard_E32s_v3"
}
module "azure_eastus2_app_vm6" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  subnet_id = module.azure_eastus2_app_region.subnet_id6
  nsg_id = module.azure_eastus2_app_region.nsg_id6
  master="eastus2"
  vm_type="Standard_D32s_v3"
}
module "azure_eastus2_app_vm7" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus"
  subnet_id = module.azure_eastus2_app_region.subnet_id7
  nsg_id = module.azure_eastus2_app_region.nsg_id7
  master="eastus2"
  vm_type="Standard_D32s_v4"
}
module "azure_eastus2_app_vm8" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus3"
  subnet_id = module.azure_eastus2_app_region.subnet_id8
  nsg_id = module.azure_eastus2_app_region.nsg_id8
  master="eastus2"
  vm_type="Standard_D32s_v3"
}

module "azure_northcentralus_app_vm1" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "centralus"
  subnet_id = module.azure_northcentralus_app_region.subnet_id1
  nsg_id = module.azure_northcentralus_app_region.nsg_id1
  master="northcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_northcentralus_app_vm2" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus"
  subnet_id = module.azure_northcentralus_app_region.subnet_id2
  nsg_id = module.azure_northcentralus_app_region.nsg_id2
  master="northcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_northcentralus_app_vm3" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  subnet_id = module.azure_northcentralus_app_region.subnet_id3
  nsg_id = module.azure_northcentralus_app_region.nsg_id3
  master="northcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_northcentralus_app_vm4" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  subnet_id = module.azure_northcentralus_app_region.subnet_id4
  nsg_id = module.azure_northcentralus_app_region.nsg_id4
  master="northcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_northcentralus_app_vm5" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  subnet_id = module.azure_northcentralus_app_region.subnet_id5
  nsg_id = module.azure_northcentralus_app_region.nsg_id5
  master="northcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_northcentralus_app_vm6" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  subnet_id = module.azure_northcentralus_app_region.subnet_id6
  nsg_id = module.azure_northcentralus_app_region.nsg_id6
  master="northcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_northcentralus_app_vm7" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus"
  subnet_id = module.azure_northcentralus_app_region.subnet_id7
  nsg_id = module.azure_northcentralus_app_region.nsg_id7
  master="northcentralus"
  vm_type="Standard_D32s_v4"
}
module "azure_northcentralus_app_vm8" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus3"
  subnet_id = module.azure_northcentralus_app_region.subnet_id8
  nsg_id = module.azure_northcentralus_app_region.nsg_id8
  master="northcentralus"
  vm_type="Standard_D32s_v3"
}

module "azure_southcentralus_app_vm1" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "centralus"
  subnet_id = module.azure_southcentralus_app_region.subnet_id1
  nsg_id = module.azure_southcentralus_app_region.nsg_id1
  master="southcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_southcentralus_app_vm2" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus"
  subnet_id = module.azure_southcentralus_app_region.subnet_id2
  nsg_id = module.azure_southcentralus_app_region.nsg_id2
  master="southcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_southcentralus_app_vm3" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  subnet_id = module.azure_southcentralus_app_region.subnet_id3
  nsg_id = module.azure_southcentralus_app_region.nsg_id3
  master="southcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_southcentralus_app_vm4" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  subnet_id = module.azure_southcentralus_app_region.subnet_id4
  nsg_id = module.azure_southcentralus_app_region.nsg_id4
  master="southcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_southcentralus_app_vm5" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  subnet_id = module.azure_southcentralus_app_region.subnet_id5
  nsg_id = module.azure_southcentralus_app_region.nsg_id5
  master="southcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_southcentralus_app_vm6" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  subnet_id = module.azure_southcentralus_app_region.subnet_id6
  nsg_id = module.azure_southcentralus_app_region.nsg_id6
  master="southcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_southcentralus_app_vm7" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus"
  subnet_id = module.azure_southcentralus_app_region.subnet_id7
  nsg_id = module.azure_southcentralus_app_region.nsg_id7
  master="southcentralus"
  vm_type="Standard_D32s_v4"
}
module "azure_southcentralus_app_vm8" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus3"
  subnet_id = module.azure_southcentralus_app_region.subnet_id8
  nsg_id = module.azure_southcentralus_app_region.nsg_id8
  master="southcentralus"
  vm_type="Standard_D32s_v3"
}

module "azure_westcentralus_app_vm1" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "centralus"
  subnet_id = module.azure_westcentralus_app_region.subnet_id1
  nsg_id = module.azure_westcentralus_app_region.nsg_id1
  master="westcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_westcentralus_app_vm2" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus"
  subnet_id = module.azure_westcentralus_app_region.subnet_id2
  nsg_id = module.azure_westcentralus_app_region.nsg_id2
  master="westcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_westcentralus_app_vm3" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  subnet_id = module.azure_westcentralus_app_region.subnet_id3
  nsg_id = module.azure_westcentralus_app_region.nsg_id3
  master="westcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_westcentralus_app_vm4" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  subnet_id = module.azure_westcentralus_app_region.subnet_id4
  nsg_id = module.azure_westcentralus_app_region.nsg_id4
  master="westcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_westcentralus_app_vm5" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  subnet_id = module.azure_westcentralus_app_region.subnet_id5
  nsg_id = module.azure_westcentralus_app_region.nsg_id5
  master="westcentralus"
  vm_type="Standard_E32s_v3"
}
module "azure_westcentralus_app_vm6" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  subnet_id = module.azure_westcentralus_app_region.subnet_id6
  nsg_id = module.azure_westcentralus_app_region.nsg_id6
  master="westcentralus"
  vm_type="Standard_D32s_v3"
}
module "azure_westcentralus_app_vm7" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus"
  subnet_id = module.azure_westcentralus_app_region.subnet_id7
  nsg_id = module.azure_westcentralus_app_region.nsg_id7
  master="westcentralus"
  vm_type="Standard_D32s_v4"
}
module "azure_westcentralus_app_vm8" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus3"
  subnet_id = module.azure_westcentralus_app_region.subnet_id8
  nsg_id = module.azure_westcentralus_app_region.nsg_id8
  master="westcentralus"
  vm_type="Standard_D32s_v3"
}

module "azure_westus_app_vm1" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "centralus"
  subnet_id = module.azure_westus_app_region.subnet_id1
  nsg_id = module.azure_westus_app_region.nsg_id1
  master="westus"
  vm_type="Standard_D32s_v3"
}
module "azure_westus_app_vm2" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus"
  subnet_id = module.azure_westus_app_region.subnet_id2
  nsg_id = module.azure_westus_app_region.nsg_id2
  master="westus"
  vm_type="Standard_E32s_v3"
}
module "azure_westus_app_vm3" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  subnet_id = module.azure_westus_app_region.subnet_id3
  nsg_id = module.azure_westus_app_region.nsg_id3
  master="westus"
  vm_type="Standard_E32s_v3"
}
module "azure_westus_app_vm4" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  subnet_id = module.azure_westus_app_region.subnet_id4
  nsg_id = module.azure_westus_app_region.nsg_id4
  master="westus"
  vm_type="Standard_D32s_v3"
}
module "azure_westus_app_vm5" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  subnet_id = module.azure_westus_app_region.subnet_id5
  nsg_id = module.azure_westus_app_region.nsg_id5
  master="westus"
  vm_type="Standard_E32s_v3"
}
module "azure_westus_app_vm6" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  subnet_id = module.azure_westus_app_region.subnet_id6
  nsg_id = module.azure_westus_app_region.nsg_id6
  master="westus"
  vm_type="Standard_D32s_v3"
}
module "azure_westus_app_vm7" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus"
  subnet_id = module.azure_westus_app_region.subnet_id7
  nsg_id = module.azure_westus_app_region.nsg_id7
  master="westus"
  vm_type="Standard_D32s_v4"
}
module "azure_westus_app_vm8" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus3"
  subnet_id = module.azure_westus_app_region.subnet_id8
  nsg_id = module.azure_westus_app_region.nsg_id8
  master="westus"
  vm_type="Standard_D32s_v3"
}

module "azure_westus3_app_vm1" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "centralus"
  subnet_id = module.azure_westus3_app_region.subnet_id1
  nsg_id = module.azure_westus3_app_region.nsg_id1
  master="westus3"
  vm_type="Standard_D32s_v3"
}
module "azure_westus3_app_vm2" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus"
  subnet_id = module.azure_westus3_app_region.subnet_id2
  nsg_id = module.azure_westus3_app_region.nsg_id2
  master="westus3"
  vm_type="Standard_E32s_v3"
}
module "azure_westus3_app_vm3" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "eastus2"
  subnet_id = module.azure_westus3_app_region.subnet_id3
  nsg_id = module.azure_westus3_app_region.nsg_id3
  master="westus3"
  vm_type="Standard_E32s_v3"
}
module "azure_westus3_app_vm4" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "northcentralus"
  subnet_id = module.azure_westus3_app_region.subnet_id4
  nsg_id = module.azure_westus3_app_region.nsg_id4
  master="westus3"
  vm_type="Standard_D32s_v3"
}
module "azure_westus3_app_vm5" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "southcentralus"
  subnet_id = module.azure_westus3_app_region.subnet_id5
  nsg_id = module.azure_westus3_app_region.nsg_id5
  master="westus3"
  vm_type="Standard_E32s_v3"
}
module "azure_westus3_app_vm6" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westcentralus"
  subnet_id = module.azure_westus3_app_region.subnet_id6
  nsg_id = module.azure_westus3_app_region.nsg_id6
  master="westus3"
  vm_type="Standard_D32s_v3"
}
module "azure_westus3_app_vm7" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus"
  subnet_id = module.azure_westus3_app_region.subnet_id7
  nsg_id = module.azure_westus3_app_region.nsg_id7
  master="westus3"
  vm_type="Standard_D32s_v4"
}
module "azure_westus3_app_vm8" {
  source   = "./modules/azure/vm"
  rg= azurerm_resource_group.terra_rg.name
  region   = "westus3"
  subnet_id = module.azure_westus3_app_region.subnet_id8
  nsg_id = module.azure_westus3_app_region.nsg_id8
  master="westus3"
  vm_type="Standard_D32s_v3"
}


// ----------------------------------------

# module "gcp_us_west1_region" {
#   source   = "./modules/gcp/region"
#   vpc      = google_compute_network.terra_vpc.name
#   region   = "us-west1"
#   ip_range = "10.135.0.0/16"

#   # one per tunnel connection
#   azure_peer_region = "westus2"
#   azure_gateway_ip0 = module.azure_westus2_region.gateway_ip_addr0
# }
# module "azure_westus2_region" {
#   source   = "./modules/azure/region"
#   rg       = azurerm_resource_group.terra_rg.name
#   region   = "westus2"
#   ip_range = "10.71.0.0/16"

#   # one per tunnel connection
#   gcp_peer_region        = "us-west1"
#   gcp_ip_range           = module.gcp_us_west1_region.ip_range
#   gcp_gateway_ip0        = module.gcp_us_west1_region.gateway_ip_addr0
#   bgp_interface_ip_addr0 = module.gcp_us_west1_region.bgp_interface_ip_addr0
#   bgp_peer_ip_addr0      = module.gcp_us_west1_region.bgp_peer_ip_addr0
# }

// ----------------------------------------

// ----------------------------------------

// ------- ADD Azure VNet peerings (they are not transitive) -----------


module "peering12" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_eastus_region.vnet_name
  vnet2_id   = module.azure_eastus_region.vnet_id
}

module "peering13" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_eastus2_region.vnet_name
  vnet2_id   = module.azure_eastus2_region.vnet_id
}

module "peering14" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_region.vnet_name
  vnet2_id   = module.azure_northcentralus_region.vnet_id
}

module "peering15" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_region.vnet_name
  vnet2_id   = module.azure_southcentralus_region.vnet_id
}

module "peering16" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_region.vnet_name
  vnet2_id   = module.azure_westcentralus_region.vnet_id
}

module "peering17" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_westus_region.vnet_name
  vnet2_id   = module.azure_westus_region.vnet_id
}

module "peering18" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_westus3_region.vnet_name
  vnet2_id   = module.azure_westus3_region.vnet_id
}


module "peering23" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus2_region.vnet_name
  vnet2_id   = module.azure_eastus2_region.vnet_id
}

module "peering24" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_northcentralus_region.vnet_name
  vnet2_id   = module.azure_northcentralus_region.vnet_id
}

module "peering25" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_southcentralus_region.vnet_name
  vnet2_id   = module.azure_southcentralus_region.vnet_id
}

module "peering26" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_westcentralus_region.vnet_name
  vnet2_id   = module.azure_westcentralus_region.vnet_id
}

module "peering27" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_westus_region.vnet_name
  vnet2_id   = module.azure_westus_region.vnet_id
}

module "peering28" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_westus3_region.vnet_name
  vnet2_id   = module.azure_westus3_region.vnet_id
}



module "peering34" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_northcentralus_region.vnet_name
  vnet2_id   = module.azure_northcentralus_region.vnet_id
}

module "peering35" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_southcentralus_region.vnet_name
  vnet2_id   = module.azure_southcentralus_region.vnet_id
}

module "peering36" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_westcentralus_region.vnet_name
  vnet2_id   = module.azure_westcentralus_region.vnet_id
}

module "peering37" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_westus_region.vnet_name
  vnet2_id   = module.azure_westus_region.vnet_id
}

module "peering38" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_westus3_region.vnet_name
  vnet2_id   = module.azure_westus3_region.vnet_id
}



module "peering45" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_region.vnet_name
  vnet2_id   = module.azure_southcentralus_region.vnet_id
}

module "peering46" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_region.vnet_name
  vnet2_id   = module.azure_westcentralus_region.vnet_id
}

module "peering47" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_westus_region.vnet_name
  vnet2_id   = module.azure_westus_region.vnet_id
}

module "peering48" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_westus3_region.vnet_name
  vnet2_id   = module.azure_westus3_region.vnet_id
}




module "peering56" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_region.vnet_name
  vnet2_id   = module.azure_westcentralus_region.vnet_id
}

module "peering57" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_westus_region.vnet_name
  vnet2_id   = module.azure_westus_region.vnet_id
}

module "peering58" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_westus3_region.vnet_name
  vnet2_id   = module.azure_westus3_region.vnet_id
}



module "peering67" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westus_region.vnet_name
  vnet2_id   = module.azure_westus_region.vnet_id
}

module "peering68" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westus3_region.vnet_name
  vnet2_id   = module.azure_westus3_region.vnet_id
}


module "peering78" {
  source     = "./modules/azure/vnet_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus3_region.vnet_name
  vnet2_id   = module.azure_westus3_region.vnet_id
}

module "azure_hub_spoke_peering11" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_centralus_app_region.vnet_name1
  vnet2_id   = module.azure_centralus_app_region.vnet_id1
}

module "azure_hub_spoke_peering12" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_centralus_app_region.vnet_name2
  vnet2_id   = module.azure_centralus_app_region.vnet_id2
}
module "azure_hub_spoke_peering13" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_centralus_app_region.vnet_name3
  vnet2_id   = module.azure_centralus_app_region.vnet_id3
}
module "azure_hub_spoke_peering14" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_centralus_app_region.vnet_name4
  vnet2_id   = module.azure_centralus_app_region.vnet_id4
}
module "azure_hub_spoke_peering15" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_centralus_app_region.vnet_name5
  vnet2_id   = module.azure_centralus_app_region.vnet_id5
}
module "azure_hub_spoke_peering16" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_centralus_app_region.vnet_name6
  vnet2_id   = module.azure_centralus_app_region.vnet_id6
}
module "azure_hub_spoke_peering17" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_centralus_app_region.vnet_name7
  vnet2_id   = module.azure_centralus_app_region.vnet_id7
}
module "azure_hub_spoke_peering18" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_centralus_region.vnet_name
  vnet1_id   = module.azure_centralus_region.vnet_id
  vnet2_name = module.azure_centralus_app_region.vnet_name8
  vnet2_id   = module.azure_centralus_app_region.vnet_id8
}

module "azure_hub_spoke_peering21" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus_app_region.vnet_name1
  vnet2_id   = module.azure_eastus_app_region.vnet_id1
}

module "azure_hub_spoke_peering22" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus_app_region.vnet_name2
  vnet2_id   = module.azure_eastus_app_region.vnet_id2
}
module "azure_hub_spoke_peering23" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus_app_region.vnet_name3
  vnet2_id   = module.azure_eastus_app_region.vnet_id3
}
module "azure_hub_spoke_peering24" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus_app_region.vnet_name4
  vnet2_id   = module.azure_eastus_app_region.vnet_id4
}
module "azure_hub_spoke_peering25" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus_app_region.vnet_name5
  vnet2_id   = module.azure_eastus_app_region.vnet_id5
}
module "azure_hub_spoke_peering26" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus_app_region.vnet_name6
  vnet2_id   = module.azure_eastus_app_region.vnet_id6
}
module "azure_hub_spoke_peering27" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus_app_region.vnet_name7
  vnet2_id   = module.azure_eastus_app_region.vnet_id7
}
module "azure_hub_spoke_peering28" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus_region.vnet_name
  vnet1_id   = module.azure_eastus_region.vnet_id
  vnet2_name = module.azure_eastus_app_region.vnet_name8
  vnet2_id   = module.azure_eastus_app_region.vnet_id8
}

module "azure_hub_spoke_peering31" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_eastus2_app_region.vnet_name1
  vnet2_id   = module.azure_eastus2_app_region.vnet_id1
}

module "azure_hub_spoke_peering32" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_eastus2_app_region.vnet_name2
  vnet2_id   = module.azure_eastus2_app_region.vnet_id2
}

module "azure_hub_spoke_peering33" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_eastus2_app_region.vnet_name3
  vnet2_id   = module.azure_eastus2_app_region.vnet_id3
}

module "azure_hub_spoke_peering34" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_eastus2_app_region.vnet_name4
  vnet2_id   = module.azure_eastus2_app_region.vnet_id4
}

module "azure_hub_spoke_peering35" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_eastus2_app_region.vnet_name5
  vnet2_id   = module.azure_eastus2_app_region.vnet_id5
}

module "azure_hub_spoke_peering36" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_eastus2_app_region.vnet_name6
  vnet2_id   = module.azure_eastus2_app_region.vnet_id6
}

module "azure_hub_spoke_peering37" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_eastus2_app_region.vnet_name7
  vnet2_id   = module.azure_eastus2_app_region.vnet_id7
}

module "azure_hub_spoke_peering38" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_eastus2_region.vnet_name
  vnet1_id   = module.azure_eastus2_region.vnet_id
  vnet2_name = module.azure_eastus2_app_region.vnet_name8
  vnet2_id   = module.azure_eastus2_app_region.vnet_id8
}

module "azure_hub_spoke_peering41" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_app_region.vnet_name1
  vnet2_id   = module.azure_northcentralus_app_region.vnet_id1
}

module "azure_hub_spoke_peering42" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_app_region.vnet_name2
  vnet2_id   = module.azure_northcentralus_app_region.vnet_id2
}
module "azure_hub_spoke_peering43" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_app_region.vnet_name3
  vnet2_id   = module.azure_northcentralus_app_region.vnet_id3
}
module "azure_hub_spoke_peering44" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_app_region.vnet_name4
  vnet2_id   = module.azure_northcentralus_app_region.vnet_id4
}
module "azure_hub_spoke_peering45" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_app_region.vnet_name5
  vnet2_id   = module.azure_northcentralus_app_region.vnet_id5
}
module "azure_hub_spoke_peering46" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_app_region.vnet_name6
  vnet2_id   = module.azure_northcentralus_app_region.vnet_id6
}
module "azure_hub_spoke_peering47" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_app_region.vnet_name7
  vnet2_id   = module.azure_northcentralus_app_region.vnet_id7
}
module "azure_hub_spoke_peering48" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_northcentralus_region.vnet_name
  vnet1_id   = module.azure_northcentralus_region.vnet_id
  vnet2_name = module.azure_northcentralus_app_region.vnet_name8
  vnet2_id   = module.azure_northcentralus_app_region.vnet_id8
}

module "azure_hub_spoke_peering51" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_app_region.vnet_name1
  vnet2_id   = module.azure_southcentralus_app_region.vnet_id1
}

module "azure_hub_spoke_peering52" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_app_region.vnet_name2
  vnet2_id   = module.azure_southcentralus_app_region.vnet_id2
}

module "azure_hub_spoke_peering53" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_app_region.vnet_name3
  vnet2_id   = module.azure_southcentralus_app_region.vnet_id3
}

module "azure_hub_spoke_peering54" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_app_region.vnet_name4
  vnet2_id   = module.azure_southcentralus_app_region.vnet_id4
}

module "azure_hub_spoke_peering55" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_app_region.vnet_name5
  vnet2_id   = module.azure_southcentralus_app_region.vnet_id5
}

module "azure_hub_spoke_peering56" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_app_region.vnet_name6
  vnet2_id   = module.azure_southcentralus_app_region.vnet_id6
}

module "azure_hub_spoke_peering57" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_app_region.vnet_name7
  vnet2_id   = module.azure_southcentralus_app_region.vnet_id7
}

module "azure_hub_spoke_peering58" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_southcentralus_region.vnet_name
  vnet1_id   = module.azure_southcentralus_region.vnet_id
  vnet2_name = module.azure_southcentralus_app_region.vnet_name8
  vnet2_id   = module.azure_southcentralus_app_region.vnet_id8
}

module "azure_hub_spoke_peering61" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_app_region.vnet_name1
  vnet2_id   = module.azure_westcentralus_app_region.vnet_id1
}

module "azure_hub_spoke_peering62" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_app_region.vnet_name2
  vnet2_id   = module.azure_westcentralus_app_region.vnet_id2
}
module "azure_hub_spoke_peering63" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_app_region.vnet_name3
  vnet2_id   = module.azure_westcentralus_app_region.vnet_id3
}
module "azure_hub_spoke_peering64" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_app_region.vnet_name4
  vnet2_id   = module.azure_westcentralus_app_region.vnet_id4
}
module "azure_hub_spoke_peering65" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_app_region.vnet_name5
  vnet2_id   = module.azure_westcentralus_app_region.vnet_id5
}
module "azure_hub_spoke_peering66" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_app_region.vnet_name6
  vnet2_id   = module.azure_westcentralus_app_region.vnet_id6
}
module "azure_hub_spoke_peering67" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_app_region.vnet_name7
  vnet2_id   = module.azure_westcentralus_app_region.vnet_id7
}
module "azure_hub_spoke_peering68" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westcentralus_region.vnet_name
  vnet1_id   = module.azure_westcentralus_region.vnet_id
  vnet2_name = module.azure_westcentralus_app_region.vnet_name8
  vnet2_id   = module.azure_westcentralus_app_region.vnet_id8
}

module "azure_hub_spoke_peering71" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus_app_region.vnet_name1
  vnet2_id   = module.azure_westus_app_region.vnet_id1
}

module "azure_hub_spoke_peering72" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus_app_region.vnet_name2
  vnet2_id   = module.azure_westus_app_region.vnet_id2
}
module "azure_hub_spoke_peering73" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus_app_region.vnet_name3
  vnet2_id   = module.azure_westus_app_region.vnet_id3
}
module "azure_hub_spoke_peering74" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus_app_region.vnet_name4
  vnet2_id   = module.azure_westus_app_region.vnet_id4
}
module "azure_hub_spoke_peering75" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus_app_region.vnet_name5
  vnet2_id   = module.azure_westus_app_region.vnet_id5
}
module "azure_hub_spoke_peering76" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus_app_region.vnet_name6
  vnet2_id   = module.azure_westus_app_region.vnet_id6
}
module "azure_hub_spoke_peering77" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus_app_region.vnet_name7
  vnet2_id   = module.azure_westus_app_region.vnet_id7
}
module "azure_hub_spoke_peering78" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus_region.vnet_name
  vnet1_id   = module.azure_westus_region.vnet_id
  vnet2_name = module.azure_westus_app_region.vnet_name8
  vnet2_id   = module.azure_westus_app_region.vnet_id8
}

module "azure_hub_spoke_peering81" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus3_region.vnet_name
  vnet1_id   = module.azure_westus3_region.vnet_id
  vnet2_name = module.azure_westus3_app_region.vnet_name1
  vnet2_id   = module.azure_westus3_app_region.vnet_id1
}

module "azure_hub_spoke_peering82" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus3_region.vnet_name
  vnet1_id   = module.azure_westus3_region.vnet_id
  vnet2_name = module.azure_westus3_app_region.vnet_name2
  vnet2_id   = module.azure_westus3_app_region.vnet_id2
}
module "azure_hub_spoke_peering83" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus3_region.vnet_name
  vnet1_id   = module.azure_westus3_region.vnet_id
  vnet2_name = module.azure_westus3_app_region.vnet_name3
  vnet2_id   = module.azure_westus3_app_region.vnet_id3
}
module "azure_hub_spoke_peering84" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus3_region.vnet_name
  vnet1_id   = module.azure_westus3_region.vnet_id
  vnet2_name = module.azure_westus3_app_region.vnet_name4
  vnet2_id   = module.azure_westus3_app_region.vnet_id4
}
module "azure_hub_spoke_peering85" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus3_region.vnet_name
  vnet1_id   = module.azure_westus3_region.vnet_id
  vnet2_name = module.azure_westus3_app_region.vnet_name5
  vnet2_id   = module.azure_westus3_app_region.vnet_id5
}
module "azure_hub_spoke_peering86" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus3_region.vnet_name
  vnet1_id   = module.azure_westus3_region.vnet_id
  vnet2_name = module.azure_westus3_app_region.vnet_name6
  vnet2_id   = module.azure_westus3_app_region.vnet_id6
}
module "azure_hub_spoke_peering87" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus3_region.vnet_name
  vnet1_id   = module.azure_westus3_region.vnet_id
  vnet2_name = module.azure_westus3_app_region.vnet_name7
  vnet2_id   = module.azure_westus3_app_region.vnet_id7
}
module "azure_hub_spoke_peering88" {
  source     = "./modules/azure/hub_spoke_peering"
  rg         = azurerm_resource_group.terra_rg.name
  vnet1_name = module.azure_westus3_region.vnet_name
  vnet1_id   = module.azure_westus3_region.vnet_id
  vnet2_name = module.azure_westus3_app_region.vnet_name8
  vnet2_id   = module.azure_westus3_app_region.vnet_id8
}
resource "google_compute_network_peering" "gcp_peering12" {
  name= "peering12"
  network      = google_compute_network.terra_vpc1.self_link
  peer_network = google_compute_network.terra_vpc2.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering13" {
  name= "peering13"
  network      = google_compute_network.terra_vpc1.self_link
  peer_network = google_compute_network.terra_vpc3.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering14" {
  name= "peering14"
  network      = google_compute_network.terra_vpc1.self_link
  peer_network = google_compute_network.terra_vpc4.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering15" {
  name= "peering15"
  network      = google_compute_network.terra_vpc1.self_link
  peer_network = google_compute_network.terra_vpc5.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering16" {
  name= "peering16"
  network      = google_compute_network.terra_vpc1.self_link
  peer_network = google_compute_network.terra_vpc6.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering17" {
  name= "peering17"
  network      = google_compute_network.terra_vpc1.self_link
  peer_network = google_compute_network.terra_vpc7.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering18" {
  name= "peering18"
  network      = google_compute_network.terra_vpc1.self_link
  peer_network = google_compute_network.terra_vpc8.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering21" {
  name= "peering21"
  network      = google_compute_network.terra_vpc2.self_link
  peer_network = google_compute_network.terra_vpc1.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering23" {
  name= "peering23"
  network      = google_compute_network.terra_vpc2.self_link
  peer_network = google_compute_network.terra_vpc3.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering24" {
  name= "peering24"
  network      = google_compute_network.terra_vpc2.self_link
  peer_network = google_compute_network.terra_vpc4.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering25" {
  name= "peering25"
  network      = google_compute_network.terra_vpc2.self_link
  peer_network = google_compute_network.terra_vpc5.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering26" {
  name= "peering26"
  network      = google_compute_network.terra_vpc2.self_link
  peer_network = google_compute_network.terra_vpc6.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering27" {
  name= "peering27"
  network      = google_compute_network.terra_vpc2.self_link
  peer_network = google_compute_network.terra_vpc7.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering28" {
  name= "peering28"
  network      = google_compute_network.terra_vpc2.self_link
  peer_network = google_compute_network.terra_vpc8.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering31" {
  name= "peering31"
  network      = google_compute_network.terra_vpc3.self_link
  peer_network = google_compute_network.terra_vpc1.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering32" {
  name= "peering32"
  network      = google_compute_network.terra_vpc3.self_link
  peer_network = google_compute_network.terra_vpc2.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering34" {
  name= "peering34"
  network      = google_compute_network.terra_vpc3.self_link
  peer_network = google_compute_network.terra_vpc4.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering35" {
  name= "peering35"
  network      = google_compute_network.terra_vpc3.self_link
  peer_network = google_compute_network.terra_vpc5.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering36" {
  name= "peering36"
  network      = google_compute_network.terra_vpc3.self_link
  peer_network = google_compute_network.terra_vpc6.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering37" {
  name= "peering37"
  network      = google_compute_network.terra_vpc3.self_link
  peer_network = google_compute_network.terra_vpc7.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering38" {
  name= "peering38"
  network      = google_compute_network.terra_vpc3.self_link
  peer_network = google_compute_network.terra_vpc8.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering41" {
  name= "peering41"
  network      = google_compute_network.terra_vpc4.self_link
  peer_network = google_compute_network.terra_vpc1.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering42" {
  name= "peering42"
  network      = google_compute_network.terra_vpc4.self_link
  peer_network = google_compute_network.terra_vpc2.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering43" {
  name= "peering43"
  network      = google_compute_network.terra_vpc4.self_link
  peer_network = google_compute_network.terra_vpc3.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering45" {
  name= "peering45"
  network      = google_compute_network.terra_vpc4.self_link
  peer_network = google_compute_network.terra_vpc5.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering46" {
  name= "peering46"
  network      = google_compute_network.terra_vpc4.self_link
  peer_network = google_compute_network.terra_vpc6.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering47" {
  name= "peering47"
  network      = google_compute_network.terra_vpc4.self_link
  peer_network = google_compute_network.terra_vpc7.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering48" {
  name= "peering48"
  network      = google_compute_network.terra_vpc4.self_link
  peer_network = google_compute_network.terra_vpc8.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering51" {
  name= "peering51"
  network      = google_compute_network.terra_vpc5.self_link
  peer_network = google_compute_network.terra_vpc1.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering52" {
  name= "peering52"
  network      = google_compute_network.terra_vpc5.self_link
  peer_network = google_compute_network.terra_vpc2.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering53" {
  name= "peering53"
  network      = google_compute_network.terra_vpc5.self_link
  peer_network = google_compute_network.terra_vpc3.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering54" {
  name= "peering54"
  network      = google_compute_network.terra_vpc5.self_link
  peer_network = google_compute_network.terra_vpc4.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering56" {
  name= "peering56"
  network      = google_compute_network.terra_vpc5.self_link
  peer_network = google_compute_network.terra_vpc6.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering57" {
  name= "peering57"
  network      = google_compute_network.terra_vpc5.self_link
  peer_network = google_compute_network.terra_vpc7.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering58" {
  name= "peering58"
  network      = google_compute_network.terra_vpc5.self_link
  peer_network = google_compute_network.terra_vpc8.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering61" {
  name= "peering61"
  network      = google_compute_network.terra_vpc6.self_link
  peer_network = google_compute_network.terra_vpc1.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering62" {
  name= "peering62"
  network      = google_compute_network.terra_vpc6.self_link
  peer_network = google_compute_network.terra_vpc2.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering63" {
  name= "peering63"
  network      = google_compute_network.terra_vpc6.self_link
  peer_network = google_compute_network.terra_vpc3.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering64" {
  name= "peering64"
  network      = google_compute_network.terra_vpc6.self_link
  peer_network = google_compute_network.terra_vpc4.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering65" {
  name= "peering65"
  network      = google_compute_network.terra_vpc6.self_link
  peer_network = google_compute_network.terra_vpc5.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering67" {
  name= "peering67"
  network      = google_compute_network.terra_vpc6.self_link
  peer_network = google_compute_network.terra_vpc7.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering68" {
  name= "peering68"
  network      = google_compute_network.terra_vpc6.self_link
  peer_network = google_compute_network.terra_vpc8.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering71" {
  name= "peering71"
  network      = google_compute_network.terra_vpc7.self_link
  peer_network = google_compute_network.terra_vpc1.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering72" {
  name= "peering72"
  network      = google_compute_network.terra_vpc7.self_link
  peer_network = google_compute_network.terra_vpc2.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering73" {
  name= "peering73"
  network      = google_compute_network.terra_vpc7.self_link
  peer_network = google_compute_network.terra_vpc3.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering74" {
  name= "peering74"
  network      = google_compute_network.terra_vpc7.self_link
  peer_network = google_compute_network.terra_vpc4.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering75" {
  name= "peering75"
  network      = google_compute_network.terra_vpc7.self_link
  peer_network = google_compute_network.terra_vpc5.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering76" {
  name= "peering76"
  network      = google_compute_network.terra_vpc7.self_link
  peer_network = google_compute_network.terra_vpc6.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering78" {
  name= "peering78"
  network      = google_compute_network.terra_vpc7.self_link
  peer_network = google_compute_network.terra_vpc8.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering81" {
  name= "peering81"
  network      = google_compute_network.terra_vpc8.self_link
  peer_network = google_compute_network.terra_vpc1.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering82" {
  name= "peering82"
  network      = google_compute_network.terra_vpc8.self_link
  peer_network = google_compute_network.terra_vpc2.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering83" {
  name= "peering83"
  network      = google_compute_network.terra_vpc8.self_link
  peer_network = google_compute_network.terra_vpc3.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering84" {
  name= "peering84"
  network      = google_compute_network.terra_vpc8.self_link
  peer_network = google_compute_network.terra_vpc4.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering85" {
  name= "peering85"
  network      = google_compute_network.terra_vpc8.self_link
  peer_network = google_compute_network.terra_vpc5.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering86" {
  name= "peering86"
  network      = google_compute_network.terra_vpc8.self_link
  peer_network = google_compute_network.terra_vpc6.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
resource "google_compute_network_peering" "gcp_peering87" {
  name= "peering87"
  network      = google_compute_network.terra_vpc8.self_link
  peer_network = google_compute_network.terra_vpc7.self_link
  export_custom_routes = true
  import_custom_routes = true
  export_subnet_routes_with_public_ip = true
  import_subnet_routes_with_public_ip = true
}
