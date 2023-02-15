# Peer vnet1 and vnet2. For a peering to work, two peering links must be created.
resource "azurerm_virtual_network_peering" "peer1" {
  name                      = "${var.vnet1_name}-peer-${var.vnet2_name}"
  resource_group_name       = var.rg
  virtual_network_name      = var.vnet1_name
  remote_virtual_network_id = var.vnet2_id
  allow_forwarded_traffic = true
  allow_gateway_transit = true
}
resource "azurerm_virtual_network_peering" "peer2" {
  name                      = "${var.vnet2_name}-peer-${var.vnet1_name}"
  resource_group_name       = var.rg
  virtual_network_name      = var.vnet2_name
  remote_virtual_network_id = var.vnet1_id
  allow_forwarded_traffic=true
  use_remote_gateways = true
}
