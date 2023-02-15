output "tunnel_key" {
    description = "IKE2 tunnel key."
    value = google_compute_vpn_tunnel.tunnel.shared_secret
}

output "bgp_peer_ip_addr" {
    description = "BGP peering address of the peer (Azure) interface."
    value = google_compute_router_peer.peer.peer_ip_address
}