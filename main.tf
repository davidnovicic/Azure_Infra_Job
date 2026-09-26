data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "security" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Security"
    ManagedBy   = "Terraform"
  }
}

module "monitoring" {
  source = "./modules/monitoring"

  name                = var.log_analytics_workspace_name
  resource_group_name = azurerm_resource_group.security.name
  location            = azurerm_resource_group.security.location

  retention_in_days = 30

  tags = {
    Environment = "Security"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_monitor_diagnostic_setting" "activity_log" {
  name                       = "activity-log-to-law"
  target_resource_id         = data.azurerm_subscription.current.id
  log_analytics_workspace_id = module.monitoring.id

  enabled_log {
    category = "Administrative"
  }

  enabled_log {
    category = "Security"
  }

  enabled_log {
    category = "ServiceHealth"
  }

  enabled_log {
    category = "Alert"
  }

  enabled_log {
    category = "Recommendation"
  }

  enabled_log {
    category = "Policy"
  }

  enabled_log {
    category = "Autoscale"
  }

  enabled_log {
    category = "ResourceHealth"
  }
}