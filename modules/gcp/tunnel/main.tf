# Create one tunnels per gateway-gateway connection (not HA)
resource "google_compute_vpn_tunnel" "tunnel" {
  name                            = var.name
  region                          = var.region
  vpn_gateway                     = var.gateway
  vpn_gateway_interface           = 0
  peer_external_gateway           = var.eg_gateway
  peer_external_gateway_interface = 0
  router                          = var.router
  ike_version                     = 2
  shared_secret                   = var.name  # just set it to the tunnel name
}

# Configure BGP sessions (one interface/peer pair  per tunnel)
resource "google_compute_router_interface" "interface" {
  name       = "${var.name}-interface"
  router     = var.router
  region     = var.region
  vpn_tunnel = google_compute_vpn_tunnel.tunnel.id
  ip_range   = "169.254.21.1/30"
}
resource "google_compute_router_peer" "peer" {
  name            = "${var.name}-peer"
  router          = var.router
  region          = var.region
  interface       = google_compute_router_interface.interface.name
  peer_asn        = 65515
  peer_ip_address = "169.254.21.2"
}
