output "host" {
  value       = azurerm_kubernetes_cluster.kube.kube_config.0.host
  description = "host value for kubernetes cluster"
}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.kube.kube_config.0.client_certificate
  description = "client certificate for kubernetes cluster"
}

output "client_key" {
  value       = azurerm_kubernetes_cluster.kube.kube_config.0.client_key
  description = "client key for kubernetes cluster"
}

output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.kube.kube_config.0.cluster_ca_certificate
  description = "cluster certificate authority for kubernetes cluster"
}

output "secrets_provider_client_id" {
  value       = azurerm_kubernetes_cluster.kube.key_vault_secrets_provider[0].secret_identity[0].client_id
  description = "client id for secrets provider in kubernetes cluster"
}

output "principal_id" {
  value       = azurerm_kubernetes_cluster.kube.identity[0].principal_id
  description = "principal id for kubernetes cluster"
}
output "node_resource_group" {
  value       = azurerm_kubernetes_cluster.kube.node_resource_group
  description = "node resource group for kubernetes cluster"
}