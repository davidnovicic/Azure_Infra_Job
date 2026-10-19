resource "azurerm_storage_account" "ingestion_test" {
  name                     = "lawingestiontest777"
  resource_group_name      = "rg-security"
  location                 = "austriaeast"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    Purpose = "LogAnalyticsIngestionTest"
  }
}

data "azurerm_monitor_diagnostic_categories" "ingestion_test_blob" {
  resource_id = "${azurerm_storage_account.ingestion_test.id}/blobServices/default"
}

resource "azurerm_monitor_diagnostic_setting" "ingestion_test_blob" {
  name                       = "blob-to-law-test"
  target_resource_id         = "${azurerm_storage_account.ingestion_test.id}/blobServices/default"
  log_analytics_workspace_id = "/subscriptions/f619463c-339d-497b-b315-61c9645d0b81/resourceGroups/rg-security/providers/Microsoft.OperationalInsights/workspaces/law-security"

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.ingestion_test_blob.log_category_types

    content {
      category = enabled_log.value
    }
  }
}
