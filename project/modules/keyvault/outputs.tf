output "kv_id" {
  value       = azurerm_key_vault.this.id
  description = "Value of the key vault id"
  sensitive   = true
}


output "tenant_id" {
  value       = azurerm_key_vault.this.tenant_id
  description = "Value of the tenant id"
  sensitive   = true
}
