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

variable "provision" {
  type        = bool
  description = "Flag indicating that the gateway must be provisioned"
  default     = true
}
