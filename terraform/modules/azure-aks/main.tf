resource "azurerm_resource_group" "this" {
  name     = "${local.resource_prefix}-aks"
  location = var.location
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.this.name
  address_space       = "10.1.0.0/16"
  subnet_prefixes     = ["10.1.1.0/24"]
  subnet_names        = ["${local.resource_prefix}-aks-subnet"]
  depends_on          = [azurerm_resource_group.this]
}

resource "azuread_group" "admins" {
  display_name = "${local.resource_prefix}-aks-admins"
}

module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.this.name
  kubernetes_version               = "1.19.11"
  orchestrator_version             = "1.19.11"
  prefix                           = local.resource_prefix
  cluster_name                     = "${local.resource_prefix}-aks"
  network_plugin                   = "azure"
  vnet_subnet_id                   = module.network.vnet_subnets[0]
  sku_tier                         = "Paid"
  enable_role_based_access_control = true
  rbac_aad_admin_group_object_ids  = [azuread_group.admins.id]
  rbac_aad_managed                 = true
  private_cluster_enabled          = false
  enable_http_application_routing  = true
  enable_auto_scaling              = true
  agents_min_count                 = 2
  agents_max_count                 = 2
  agents_count                     = null

  depends_on = [module.network]
}
