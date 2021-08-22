terraform {
  backend "azurerm" {
    resource_group_name  = "numbers-prod-tfstate"
    storage_account_name = "numbersprodtfstate"
    container_name       = "numbers-prod-tfstate"
    key                  = "zone.tfstate"
  }
}
