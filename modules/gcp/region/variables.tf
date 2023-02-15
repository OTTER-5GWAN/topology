variable "vpc" {
    description = "Name of the VPC the region is in."
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

variable "azure_peer_region" {
    description = "Name of Azure region on the other end of the peering link."
    type = string
}

variable "azure_gateway_ip0" {
    description = "Azure VPN gateway public IP (single interface)."
    type = string
}

variable "azure_gateway_ip1" {
    description = "Azure VPN gateway public IP (single interface)."
    type = string
}

variable "azure_ip_range" {
    description = "Name of Azure region on the other end of the peering link."
    type = string
}

variable "azure_app_ip_range" {
    description = "Name of Azure region on the other end of the peering link."
    type = string
}

variable "sec_ip_range" {
    description = "secondary IP range of region."
    type = string
}
