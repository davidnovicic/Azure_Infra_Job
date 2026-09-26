output "subscription_id" {
  description = "Azure subscription ID."
  value       = data.azurerm_subscription.current.subscription_id
}

output "resource_group_name" {
  description = "Security resource group name."
  value       = azurerm_resource_group.security.name
}

output "resource_group_id" {
  description = "Security resource group ID."
  value       = azurerm_resource_group.security.id
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = module.monitoring.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace."
  value       = module.monitoring.name
}

output "log_analytics_workspace_workspace_id" {
  description = "Workspace ID of the Log Analytics workspace."
  value       = module.monitoring.workspace_id
}