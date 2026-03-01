output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "login server value for container registry"
}

output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "id of container registry"
}

output "admin_username" {
  value       = azurerm_container_registry.acr.admin_username
  description = "admin username for container registry"
}
output "admin_password" {
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
  description = "admin password for container registry"
}