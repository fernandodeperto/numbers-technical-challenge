output "ARM_CLIENT_ID" {
  value = azuread_application.this.application_id
}

output "ARM_SUBSCRIPTION_ID" {
  value = data.azurerm_subscription.primary.id
}

output "ARM_TENANT_ID" {
  value = data.azurerm_subscription.primary.tenant_id
}

output "ARM_CLIENT_SECRET" {
  sensitive = true
  value     = azuread_service_principal_password.this.value
}
