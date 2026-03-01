output "host" {
  value = azurerm_kubernetes_cluster.kube.kube_config.0.host
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.kube.kube_config.0.client_certificate
}

output "client_key" {
  value = azurerm_kubernetes_cluster.kube.kube_config.0.client_key
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.kube.kube_config.0.cluster_ca_certificate
}

output "secrets_provider_client_id" {
  value = azurerm_kubernetes_cluster.kube.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "principal_id" {
  value = azurerm_kubernetes_cluster.kube.identity[0].principal_id
}
output "node_resource_group" {
  value = azurerm_kubernetes_cluster.kube.node_resource_group
}