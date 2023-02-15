variable "rg" {
    description = "Name of the resource group the region is in."
    type = string
}

variable "region" {
    description = "Region name."
    type = string
}

variable "ip_range" {
    description = "IP range of region."
    type = string
}

variable "gcp_peer_region" {
    description = "Name of GCP region on other end of the peering link."
    type = string
}
variable "gcp_ip_range" {
    description = "GCP region IP range."
    type = string
}

variable "gcp_gateway_ip0" {
    description = "GCP region VPN gateway public IP (single interface)."
    type = string
}

/*
variable "bgp_interface_ip_addr0" {
    description = "The BGP peering address of the GCP BGP speaker."
    type = string
}


variable "bgp_peer_ip_addr0" {
    description = "The BGP peering address of this (Azure) BGP speaker."
    type = string
}
*/
variable "gcp_gateway_ip1" {
 description = "GCP region VPN gateway public IP (single interface)."
    type = string
}
variable "gcp_gateway_ip2" {
 description = "GCP region VPN gateway public IP (single interface)."
    type = string
}
variable "gcp_gateway_ip3" {
 description = "GCP region VPN gateway public IP (single interface)."
    type = string
}

/*
variable "bgp_interface_ip_addr1" {
    description = "The BGP peering address of the GCP BGP speaker."
    type = string
}


variable "bgp_peer_ip_addr1" {
    description = "The BGP peering address of this (Azure) BGP speaker."
    type = string
}
*/
