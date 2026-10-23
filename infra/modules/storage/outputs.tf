output "id" {
  value = azurerm_storage_account.this.id
}

output "name" {
  value = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_landing" {
  value = azurerm_storage_container.landing.name
}

output "container_quarantine" {
  value = azurerm_storage_container.quarantine.name
}

output "container_archive" {
  value = azurerm_storage_container.archive.name
}
