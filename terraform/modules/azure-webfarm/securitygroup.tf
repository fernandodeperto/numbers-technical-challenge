resource "azurerm_network_security_group" "this" {
  name                = local.resource_prefix
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = local.default_tags
}

resource "azurerm_network_security_rule" "this" {
  resource_group_name         = azurerm_resource_group.this.name
  name                        = "HTTP"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.this.name
}
