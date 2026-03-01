output "fqdn" {
  description = "Fully Qualified Domain Name (FQDN) for the deployed container in Azure Container Instance"
  value       = azurerm_container_group.this.fqdn
  sensitive   = true
}
