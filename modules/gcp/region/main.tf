# Create a VPC subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.region}-region-distinct"
  region        = var.region
  ip_cidr_range = var.ip_range
  network       = var.vpc
  /*
  secondary_ip_range {
      range_name = "${var.region}-region-subnet"
      ip_cidr_range = var.sec_ip_range
  }
  */
}

# Create a cloud router
resource "google_compute_router" "router" {
  name    = "${var.region}-router"
  region  = var.region
  network = var.vpc
  bgp {
    asn = 65516
    advertise_mode = "CUSTOM"

    advertised_ip_ranges {
      range = "10.128.0.0/16"
    }
    advertised_ip_ranges {
      range = "10.129.0.0/16"
    }
    advertised_ip_ranges {
      range = "10.130.0.0/16"
    }
    advertised_ip_ranges {
      range = "10.131.0.0/16"
    }
    advertised_ip_ranges {
      range = "10.132.0.0/16"
    }
    advertised_ip_ranges {
      range = "10.133.0.0/16"
    }
    advertised_ip_ranges {
      range = "10.134.0.0/16"
    }
    advertised_ip_ranges {
      range = "10.136.0.0/16"
    }
  }
  
}
resource "google_compute_vpn_gateway" "target_gateway1" {
  name    = "${var.region}-gateway1"
  region  = var.region
  network = var.vpc
}

resource "google_compute_address" "vpn_static_ip1" {
  name = "${var.region}-vpn-static-ip1"
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_esp_1" {
  name        = "fr-esp-1"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip1.address
  target      = google_compute_vpn_gateway.target_gateway1.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_udp500_1" {
  name        = "fr-udp500-1"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip1.address
  target      = google_compute_vpn_gateway.target_gateway1.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_udp4500_1" {
  name        = "fr-udp4500-1"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip1.address
  target      = google_compute_vpn_gateway.target_gateway1.id
  region  = var.region
}

resource "google_compute_vpn_tunnel" "tunnel1-1" {
  name          = "${var.region}-tunnel1-1"
  peer_ip       = var.azure_gateway_ip0
  shared_secret = "YOUR OWN KEY"
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway1.id
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]
  depends_on = [
    google_compute_forwarding_rule.fr_esp_1,
    google_compute_forwarding_rule.fr_udp500_1,
    google_compute_forwarding_rule.fr_udp4500_1,
  ]

}
resource "google_compute_vpn_tunnel" "tunnel1-2" {
  name          = "${var.region}-tunnel1-2"
  peer_ip       = var.azure_gateway_ip1
  shared_secret = "YOUR OWN KEY"
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway1.id
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector=["0.0.0.0/0"]
  depends_on = [
    google_compute_forwarding_rule.fr_esp_1,
    google_compute_forwarding_rule.fr_udp500_1,
    google_compute_forwarding_rule.fr_udp4500_1,
  ]

}

resource "google_compute_route" "route1-1-1" {
  name       = "${var.region}-route1-1-1"
  network    = var.vpc
  dest_range = var.azure_ip_range
  #dest_range = "10.64.0.0/10"
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1-1.id
}

resource "google_compute_route" "route1-1-2" {
  name       = "${var.region}-route1-1-2"
  network    = var.vpc
  dest_range = var.azure_app_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1-1.id
}


resource "google_compute_route" "route1-2-1" {
  name       = "${var.region}-route1-2-1"
  network    = var.vpc
  dest_range = var.azure_ip_range
  #dest_range = "10.64.0.0/10"
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1-2.id
}

resource "google_compute_route" "route1-2-2" {
  name       = "${var.region}-route1-2-2"
  network    = var.vpc
  dest_range = var.azure_app_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1-2.id
}

resource "google_compute_vpn_gateway" "target_gateway2" {
  name    = "${var.region}-gateway2"
  region  = var.region
  network = var.vpc
}

resource "google_compute_address" "vpn_static_ip2" {
  name = "${var.region}-vpn-static-ip2"
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_esp_2" {
  name        = "fr-esp-2"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip2.address
  target      = google_compute_vpn_gateway.target_gateway2.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_udp500_2" {
  name        = "fr-udp500-2"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip2.address
  target      = google_compute_vpn_gateway.target_gateway2.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_udp4500_2" {
  name        = "fr-udp4500-2"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip2.address
  target      = google_compute_vpn_gateway.target_gateway2.id
  region  = var.region
}

resource "google_compute_vpn_tunnel" "tunnel2-1" {
  name          = "${var.region}-tunnel2-1"
  peer_ip       = var.azure_gateway_ip0
  shared_secret = "YOUR OWN KEY"
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway2.id
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector=["0.0.0.0/0"]
  depends_on = [
    google_compute_forwarding_rule.fr_esp_2,
    google_compute_forwarding_rule.fr_udp500_2,
    google_compute_forwarding_rule.fr_udp4500_2,
  ]

}
resource "google_compute_vpn_tunnel" "tunnel2-2" {
  name          = "${var.region}-tunnel2-2"
  peer_ip       = var.azure_gateway_ip1
  shared_secret = "YOUR OWN KEY"
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway2.id
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector=["0.0.0.0/0"]
  depends_on = [
    google_compute_forwarding_rule.fr_esp_2,
    google_compute_forwarding_rule.fr_udp500_2,
    google_compute_forwarding_rule.fr_udp4500_2,
  ]

}


resource "google_compute_route" "route2-1-1" {
  name       = "${var.region}-route2-1-1"
  network    = var.vpc
  dest_range = var.azure_ip_range 
  #dest_range = "10.64.0.0/10"
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel2-1.id
}

resource "google_compute_route" "route2-1-2" {
  name       = "${var.region}-route2-1-2"
  network    = var.vpc
  dest_range = var.azure_app_ip_range 
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel2-1.id
}


resource "google_compute_route" "route2-2-1" {
  name       = "${var.region}-route2-2-1"
  network    = var.vpc
  dest_range = var.azure_ip_range
  #dest_range = "10.64.0.0/10"
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel2-2.id
}

resource "google_compute_route" "route2-2-2" {
  name       = "${var.region}-route2-2-2"
  network    = var.vpc
  dest_range = var.azure_app_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel2-2.id
}

resource "google_compute_vpn_gateway" "target_gateway3" {
  name    = "${var.region}-gateway3"
  region  = var.region
  network = var.vpc
}

resource "google_compute_address" "vpn_static_ip3" {
  name = "${var.region}-vpn-static-ip3"
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_esp_3" {
  name        = "fr-esp-3"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip3.address
  target      = google_compute_vpn_gateway.target_gateway3.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_udp500_3" {
  name        = "fr-udp500-3"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip3.address
  target      = google_compute_vpn_gateway.target_gateway3.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_udp4500_3" {
  name        = "fr-udp4500-3"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip3.address
  target      = google_compute_vpn_gateway.target_gateway3.id
  region  = var.region
}

resource "google_compute_vpn_tunnel" "tunnel3-1" {
  name          = "${var.region}-tunnel3-1"
  peer_ip       = var.azure_gateway_ip0
  shared_secret = "YOUR OWN KEY"
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway3.id
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]
  depends_on = [
    google_compute_forwarding_rule.fr_esp_3,
    google_compute_forwarding_rule.fr_udp500_3,
    google_compute_forwarding_rule.fr_udp4500_3,
  ]

}
resource "google_compute_vpn_tunnel" "tunnel3-2" {
  name          = "${var.region}-tunnel3-2"
  peer_ip       = var.azure_gateway_ip1
  shared_secret = "YOUR OWN KEY"
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway3.id
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector=["0.0.0.0/0"]
  depends_on = [
    google_compute_forwarding_rule.fr_esp_3,
    google_compute_forwarding_rule.fr_udp500_3,
    google_compute_forwarding_rule.fr_udp4500_3,
  ]

}

resource "google_compute_route" "route3-1-1" {
  name       = "${var.region}-route3-1-1"
  network    = var.vpc
  dest_range = var.azure_ip_range
  #dest_range = "10.64.0.0/10"
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel3-1.id
}
resource "google_compute_route" "route3-1-2" {
  name       = "${var.region}-route3-1-2"
  network    = var.vpc
  dest_range = var.azure_app_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel3-1.id
}

resource "google_compute_route" "route3-2-1" {
  name       = "${var.region}-route3-2-1"
  network    = var.vpc
  dest_range = var.azure_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel3-2.id
}
resource "google_compute_route" "route3-2-2" {
  name       = "${var.region}-route3-2-2"
  network    = var.vpc
  dest_range = var.azure_app_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel3-2.id
}

resource "google_compute_vpn_gateway" "target_gateway4" {
  name    = "${var.region}-gateway4"
  region  = var.region
  network = var.vpc
}

resource "google_compute_address" "vpn_static_ip4" {
  name = "${var.region}-vpn-static-ip4"
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_esp_4" {
  name        = "fr-esp-4"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip4.address
  target      = google_compute_vpn_gateway.target_gateway4.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_udp500_4" {
  name        = "fr-udp500-4"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip4.address
  target      = google_compute_vpn_gateway.target_gateway4.id
  region  = var.region
}

resource "google_compute_forwarding_rule" "fr_udp4500_4" {
  name        = "fr-udp4500-4"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip4.address
  target      = google_compute_vpn_gateway.target_gateway4.id
  region  = var.region
}

resource "google_compute_vpn_tunnel" "tunnel4-1" {
  name          = "${var.region}-tunnel4-1"
  peer_ip       = var.azure_gateway_ip0
  shared_secret = "YOUR OWN KEY"
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway4.id
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]
  depends_on = [
    google_compute_forwarding_rule.fr_esp_4,
    google_compute_forwarding_rule.fr_udp500_4,
    google_compute_forwarding_rule.fr_udp4500_4,
  ]

}
resource "google_compute_vpn_tunnel" "tunnel4-2" {
  name          = "${var.region}-tunnel4-2"
  peer_ip       = var.azure_gateway_ip1
  shared_secret = "YOUR OWN KEY"
  target_vpn_gateway = google_compute_vpn_gateway.target_gateway4.id
  local_traffic_selector = ["0.0.0.0/0"]
  remote_traffic_selector=["0.0.0.0/0"]
  depends_on = [
    google_compute_forwarding_rule.fr_esp_4,
    google_compute_forwarding_rule.fr_udp500_4,
    google_compute_forwarding_rule.fr_udp4500_4,
  ]

}

resource "google_compute_route" "route4-1-1" {
  name       = "${var.region}-route4-1-1"
  network    = var.vpc
  dest_range = var.azure_ip_range
  #dest_range = "10.64.0.0/10"
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel4-1.id
}
resource "google_compute_route" "route4-1-2" {
  name       = "${var.region}-route4-1-2"
  network    = var.vpc
  dest_range = var.azure_app_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel4-1.id
}

resource "google_compute_route" "route4-2-1" {
  name       = "${var.region}-route4-2-1"
  network    = var.vpc
  dest_range = var.azure_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel4-2.id
}
resource "google_compute_route" "route4-2-2" {
  name       = "${var.region}-route4-2-2"
  network    = var.vpc
  dest_range = var.azure_app_ip_range
  priority   = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel4-2.id
}

# Create GCP vpc VM
resource "google_compute_instance" "vm" {
  name                      = "${var.region}-vm-distinct"
  zone                      = "${var.region}-b"
  machine_type              = "n2-standard-32"
  allow_stopping_for_update = true
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20220530"
      size  = 64
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {
      // Gives emphemeral public IP
    }
  }
}

