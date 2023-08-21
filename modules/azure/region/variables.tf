variable "rg" {
  description = "Name of the resource group the region is in."
  type        = string
}

variable "region" {
  description = "Region name."
  type        = string
}

variable "ip_range" {
  description = "IP address range of region."
  type        = string
}

variable "gcp_peer_region" {
  description = "Name of GCP region on other end of the peering link."
  type        = string
}

variable "gcp_ip_range" {
  description = "GCP region IP address range."
  type        = string
}

variable "gcp_gateway_ip0" {
  description = "GCP region VPN gateway public IP address (single interface)."
  type        = string
}

variable "gcp_gateway_ip1" {
  description = "GCP region VPN gateway public IP address (single interface)."
  type        = string
}

variable "gcp_gateway_ip2" {
  description = "GCP region VPN gateway public IP address (single interface)."
  type        = string
}

variable "gcp_gateway_ip3" {
  description = "GCP region VPN gateway public IP address (single interface)."
  type        = string
}