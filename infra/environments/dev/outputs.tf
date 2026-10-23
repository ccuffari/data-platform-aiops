output "resource_group_name" {
  value = module.rg_main.name
}

output "resource_group_id" {
  value = module.rg_main.id
}
output "storage_account_name" {
  value = module.storage.name
}

output "storage_primary_blob_endpoint" {
  value = module.storage.primary_blob_endpoint
}
output "keyvault_name" {
  value = module.keyvault.name
}

output "keyvault_uri" {
  value = module.keyvault.vault_uri
}
