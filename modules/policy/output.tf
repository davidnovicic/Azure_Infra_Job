output "policy_assignment_id" {
  description = "ID of the Azure Policy assignment."
  value       = azurerm_subscription_policy_assignment.require_environment_tag.id
}

output "policy_assignment_name" {
  description = "Name of the Azure Policy assignment."
  value       = azurerm_subscription_policy_assignment.require_environment_tag.name
}