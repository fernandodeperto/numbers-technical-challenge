resource "azurerm_resource_group" "this" {
  name     = local.resource_prefix
  location = var.location

  tags = local.default_tags
}

resource "azurerm_virtual_network" "this" {
  name                = local.resource_prefix
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = local.default_tags
}

resource "azurerm_subnet" "this" {
  name                 = local.resource_prefix
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "this" {
  name                = local.resource_prefix
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"

  tags = local.default_tags
}

resource "azurerm_lb" "this" {
  name                = local.resource_prefix
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  frontend_ip_configuration {
    name                 = local.resource_prefix
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

# resource "azurerm_lb_backend_address_pool" "this" {
#  resource_group_name = azurerm_resource_group.this.name
#  loadbalancer_id     = azurerm_lb.this.id
#  name                = local.resource_prefix
# }

resource "azurerm_network_security_group" "this" {
  name                = local.resource_prefix
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.default_tags
}

# resource "azurerm_network_interface" "this" {
#   name                = local.resource_prefix
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name

#   ip_configuration {
#     name                          = local.resource_prefix
#     subnet_id                     = azurerm_subnet.this.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.this.id
#   }

#   tags = local.default_tags
# }

resource "azurerm_monitor_autoscale_setting" "this" {
  name                = local.resource_prefix
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
  name                = local.resource_prefix
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard_F2"
  instances           = 2
  admin_username      = "adminuser"
  custom_data         = base64encode(data.template_file.this.rendered)

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/personal.pub")
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
    name    = local.resource_prefix
    primary = true

    ip_configuration {
      name      = local.resource_prefix
      primary   = true
      subnet_id = azurerm_subnet.this.id
    }
  }

  tags = local.default_tags
}
