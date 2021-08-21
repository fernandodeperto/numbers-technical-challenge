data "template_file" "this" {
  template = file("${path.module}/custom_data.sh.tpl")

  vars = {
    branch = var.branch
  }
}

data "azurerm_dns_zone" "example" {
  name                = "search-eventhubns"
  resource_group_name = "search-service"
}

# output "dns_zone_id" {
#   value = data.azurerm_dns_zone.example.id
# }

data "terraform_remote_state" "zone" {
  backend = "azurerm"

  config = {
    resource_group_name  = "numbers-test-tfstate"
    storage_account_name = "numberstesttfstate"
    container_name       = "numbers-test-tfstate"
    key                  = "zone.tfstate"
  }
}
