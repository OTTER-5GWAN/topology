# Input variable definitions

variable "vpc" {
    description = "ID of the VPC the firewall is associated with."
    type = string
}

variable "gcp_ips" {
    description = "IP ranges associated with GCP WAN"
    type = list(string)
}

variable "azure_ips" {
    description = "IP ranges associated with Azure WAN"
    type = list(string)
}

