# Resource Group Variables
variable "resource_group_id" {
  type        = string
  description = "The id of the IBM Cloud resource group where the VPC gateways will be created."
}

variable "region" {
  type        = string
  description = "The IBM Cloud region where the cluster will be/has been installed."
}

variable "vpc_name" {
  type        = string
  description = "The name of the vpc instance"
}

variable "subnet_count" {
  type        = number
  description = "The total number of subnets that will be provisioned in the VPC instance. This value will be used to determine how many gateways to create. At most, three gateways can be created (one for each zone) so the default should suffice in most cases. However, it might create more gateways than needed for small deployments in which case a number less than three can be used."
  default     = 3
}

variable "provision" {
  type        = bool
  description = "Flag indicating that the gateway must be provisioned"
  default     = true
}
