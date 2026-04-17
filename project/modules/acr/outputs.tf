output "acr_login_server" {
  description = "The login server for the Azure Container Registry"
  value       = azurerm_container_registry.this.login_server
  sensitive   = true
}

output "identity_id" {
  description = "The ID of the user-assigned identity."
  value       = azurerm_user_assigned_identity.this.id
  sensitive   = true
}

output "acr_id" {
  description = "The ID of the Azure Container Registry."
  value       = azurerm_container_registry.this.id
  sensitive   = true
}
