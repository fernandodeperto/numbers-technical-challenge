resource "azurerm_resource_group" "remote_state" {
  name     = local.resource_prefix
  location = "westeurope"
}

resource "azurerm_storage_account" "remote_state" {
  name                     = replace(local.resource_prefix, "-", "")
  resource_group_name      = azurerm_resource_group.remote_state.name
  location                 = azurerm_resource_group.remote_state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.default_tags
}

resource "azurerm_storage_container" "remote_state" {
  name                  = local.resource_prefix
  storage_account_name  = azurerm_storage_account.remote_state.name
  container_access_type = "private"
}
