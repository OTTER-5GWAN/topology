variable "name" {
    description = "Name of the tunnel."
    type = string
}

variable "region" {
    description = "Region name."
    type = string
}

variable "router" {
    description = "Name of cloud router associated with tunnel."
    type = string
}

variable "gateway" {
    description = "GCP VPN gateway ID."
    type = string
}

variable "eg_gateway" {
    description = "GCP VPN external gateway ID."
    type = string
}