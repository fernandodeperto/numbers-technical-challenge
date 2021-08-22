resource "azurerm_resource_group" "this" {
  name     = "${local.resource_prefix}-zone"
  location = var.location

  tags = local.default_tags
}

resource "azurerm_dns_zone" "this" {
  name                = "apilabs.xyz"
  resource_group_name = azurerm_resource_group.this.name

  tags = local.default_tags
}
