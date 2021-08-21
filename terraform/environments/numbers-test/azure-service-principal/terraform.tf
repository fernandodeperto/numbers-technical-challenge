terraform {
  backend "azurerm" {
    resource_group_name  = "numbers-test-tfstate"
    storage_account_name = "numberstesttfstate"
    container_name       = "numbers-test-tfstate"
    key                  = "service-principal.tfstate"
  }
}
