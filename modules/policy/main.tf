resource "azurerm_subscription_policy_assignment" "require_environment_tag" {
  name                 = "require-environment-tag"
  display_name         = "Require Environment tag"
  description          = "Requires resources to have an Environment tag."
  subscription_id      = var.subscription_id
  policy_definition_id = var.policy_definition_id

  parameters = jsonencode({
    tagName = {
      value = var.tag_name
    }
  })
}