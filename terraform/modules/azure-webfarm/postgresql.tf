resource "random_password" "postgresql" {
  length  = 16
  special = false
}

resource "azurerm_postgresql_server" "this" {
  name                = "${local.resource_prefix}-postgres"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = "postgres"
  administrator_login_password = random_password.postgresql.result

  sku_name   = "GP_Gen5_2"
  version    = "9.6"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled = false
  ssl_enforcement_enabled       = false
}

resource "azurerm_private_endpoint" "this" {
  name                = "${local.resource_prefix}-postgre-endpoint"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.this.id

  private_service_connection {
    name                           = "${local.resource_prefix}-postgre-connection"
    private_connection_resource_id = azurerm_postgresql_server.this.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }
}

resource "azurerm_postgresql_database" "this" {
  for_each            = local.postgres_dbs
  name                = each.key
  resource_group_name = azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.this.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
