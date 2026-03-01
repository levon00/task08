output "key_vault_name" {
  value       = azurerm_key_vault.keyvault.name
  description = "name of key vault"
}
output "key_vault_id" {
  value       = azurerm_key_vault.keyvault.id
  description = "id of key vault"
}
