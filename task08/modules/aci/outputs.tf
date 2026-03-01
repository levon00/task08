output "fqdn" {
  value       = azurerm_container_group.container_group.fqdn
  description = "fully qualified domain name for container group"
}