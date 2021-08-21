data "template_file" "this" {
  template = file("${path.module}/custom_data.sh.tpl")

  vars = {
    branch = var.branch
  }
}

data "azurerm_dns_zone" "this" {
  name                = "apilabs.xyz"
  resource_group_name = "${lower(replace(var.project, " ", ""))}-prod-zone"
}
