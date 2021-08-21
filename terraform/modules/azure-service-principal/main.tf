resource "azuread_application" "application" {
  display_name = local.resource_prefix
}

resource "azuread_service_principal" "example" {
  application_id               = azuread_application.application.application_id
  app_role_assignment_required = false
}
