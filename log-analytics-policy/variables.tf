variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
  default     = "austria east"
}

variable "resource_group_name" {
  description = "Name of the resource group used by the security infrastructure."
  type        = string
  default     = "rg-security"
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace."
  type        = string
  default     = "law-security"
}