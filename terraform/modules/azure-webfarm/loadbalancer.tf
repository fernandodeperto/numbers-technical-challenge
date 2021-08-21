resource "azurerm_lb" "this" {
  name                = "${local.resource_prefix}-lb"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  frontend_ip_configuration {
    name                 = local.resource_prefix
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = local.default_tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = "${local.resource_prefix}-addressPool"
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "this" {
  name                = "${local.resource_prefix}-probe"
  resource_group_name = azurerm_resource_group.this.name
  loadbalancer_id     = azurerm_lb.this.id
  port                = 80
}

resource "azurerm_lb_rule" "this" {
  name                           = "${local.resource_prefix}-rule"
  resource_group_name            = azurerm_resource_group.this.name
  loadbalancer_id                = azurerm_lb.this.id
  probe_id                       = azurerm_lb_probe.this.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration.0.name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.this.id
}

resource "azurerm_lb_nat_pool" "this" {
  name                           = "${local.resource_prefix}-natPool"
  resource_group_name            = azurerm_resource_group.this.name
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.this.frontend_ip_configuration.0.name
}
