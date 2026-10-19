terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "storagedavidtfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

    use_oidc         = true
    use_azuread_auth = true
    tenant_id        = "4bd7928d-756a-4396-8d8f-803e40dd52db"
    client_id        = "e3fb2798-1aff-43a6-b02d-1078f245995d"
  }
}