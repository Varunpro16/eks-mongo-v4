# variables.tf

variable "rg" {
  description = "Resource Group"
  type        = string
}

variable "node_count" {
  description = "Node Count"
  type        = number
}

variable "vm_size" {
  description = "Name of the vm type"
  type        = string
}

variable "dns_link_name" {
  description = "Name of dns"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "pr_connection_name" {
   description = "Name of Private connection"
  type        = string
}


variable "location" {
  description = "Location"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_address_range" {
  description = "Address ranges for the VPC"
  type        = list(string)
}
variable "az_pre_end_name" {
  description = "Name of the private endpoint"
  type        = string
}


variable "cosmosdb_name"{
  description = "Name of the db"
  type        = string
}