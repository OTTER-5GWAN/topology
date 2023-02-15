variable "rg" {
    description = "Name of the resource group the region is in."
    type = string
}

variable "region" {
    description = "Region name."
    type = string
}

variable "subnet_id" {
    description = "subNet id 1."
    type = string
}

variable "nsg_id" {
    description = "NSG id 1."
    type = string
}

variable "master" {
    description = "master node (hub node)."
    type = string
}

variable "vm_type" {
    description = "vm type."
    type = string
}


