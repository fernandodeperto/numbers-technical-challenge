resource "azurerm_network_security_group" "this" {
  name                = "${local.resource_prefix}-securityGroup"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = local.default_tags
}

resource "azurerm_network_security_rule" "http" {
  name                        = "${local.resource_prefix}-securityRule-http"
  resource_group_name         = azurerm_resource_group.this.name
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 8000
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.this.name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "${local.resource_prefix}-securityRule-ssh"
  resource_group_name         = azurerm_resource_group.this.name
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 22
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.this.name
}
