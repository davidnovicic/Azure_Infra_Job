variable "subscription_id" {
  description = "Azure subscription ID where the policy will be assigned."
  type        = string
}

variable "policy_definition_id" {
  description = "ID of the Azure Policy definition to assign."
  type        = string
}

variable "tag_name" {
  description = "Name of the tag that resources must have."
  type        = string
  default     = "Environment"
}