resource "azurerm_storage_account" "velero" {
  name                     = "${replace(local.resource_prefix, "-", "")}velero"
  resource_group_name      = module.aks.node_resource_group
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.default_tags
}

resource "azurerm_storage_container" "velero" {
  name                  = "${local.resource_prefix}-velero"
  storage_account_name  = azurerm_storage_account.velero.name
  container_access_type = "private"
}
