variable "name" {
  description = "Name of the Log Analytics workspace."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the workspace will be created."
  type        = string
}

variable "location" {
  description = "Azure region where the workspace will be created."
  type        = string
}

variable "retention_in_days" {
  description = "Number of days to retain Log Analytics data."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to the workspace."
  type        = map(string)
  default     = {}
}