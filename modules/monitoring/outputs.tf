output "id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics_777.id
}

output "name" {
  description = "Name of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics_777.name
}

output "workspace_id" {
  description = "Workspace ID used by Azure services."
  value       = azurerm_log_analytics_workspace.log_analytics_777.workspace_id
}

output "location" {
  description = "Location of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics_777.location
}