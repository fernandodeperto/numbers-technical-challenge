resource "azurerm_resource_group" "this" {
  name     = local.resource_prefix
  location = var.location

  tags = local.default_tags
}

resource "azurerm_monitor_autoscale_setting" "this" {
  name                = "${local.resource_prefix}-autoscale"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.this.id

  profile {
    name = "Work"

    capacity {
      default = 4
      minimum = 1
      maximum = 4
    }

    recurrence {
      timezone = "UTC"
      days     = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
      hours    = [8]
      minutes  = [0]
    }
  }

  profile {
    name = "Play"

    capacity {
      default = 1
      minimum = 1
      maximum = 4
    }

    recurrence {
      timezone = "UTC"
      days     = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
      hours    = [16]
      minutes  = [0]
    }
  }
}

resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = "${local.resource_prefix}-scaleSet"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"
  health_probe_id     = azurerm_lb_probe.this.id

  custom_data = base64encode(data.template_file.this.rendered)

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                      = local.resource_prefix
    primary                   = true
    network_security_group_id = azurerm_network_security_group.this.id

    ip_configuration {
      name                                   = local.resource_prefix
      primary                                = true
      subnet_id                              = azurerm_subnet.this.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.this.id]
      # load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.this.id]
    }
  }

  tags = local.default_tags

  depends_on = [azurerm_lb_rule.this]
}

resource "azurerm_dns_a_record" "this" {
  name                = local.resource_prefix
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = "${lower(replace(var.project, " ", ""))}-prod-zone"
  ttl                 = 300
  records             = [azurerm_public_ip.this.ip_address]
}

resource "random_string" "flask_secret_key" {
  length  = 32
  special = false
}
