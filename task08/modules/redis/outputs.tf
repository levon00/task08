output "redis_hostname" {
  value       = azurerm_key_vault_secret.redis_hostname.name
  description = "name of redis hostname secret in key vault"
}

output "redis_key" {
  value       = azurerm_key_vault_secret.redis_key.name
  description = "name of redis key secret in key vault"
}