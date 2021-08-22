output "resource_group_id" {
  value = azurerm_resource_group.remote_state.id
}

output "storage_account_id" {
  value = azurerm_storage_account.remote_state.id
}

output "storage_container_id" {
  value = azurerm_storage_container.remote_state.id
}
