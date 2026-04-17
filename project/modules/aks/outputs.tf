output "kv_access_identity_id" {
  description = "The identity (object) ID of the AKS cluster used for accessing Key Vault"
  value       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id
  sensitive   = true
}

output "kubeconfig_filename" {
  description = "The filename of the kubeconfig file"
  value       = local_file.kubeconfig.filename
}
