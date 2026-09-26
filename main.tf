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