variable "rg" {
  description = "Name of the resource group the region is in."
  type        = string
}

variable "region" {
  description = "Region name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet id 1."
  type        = string
}

variable "nsg_id" {
  description = "Network security group id 1."
  type        = string
}

variable "master" {
  description = "Master node (hub node)."
  type        = string
}

variable "vm_type" {
  description = "VM type."
  type        = string
}