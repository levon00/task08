resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "pref-${var.name}"

  default_node_pool {
    name            = var.node_pool_name
    node_count      = var.node_count
    vm_size         = var.vm_size
    os_disk_type    = var.disk_type
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = var.kv_id
  tenant_id    = azurerm_kubernetes_cluster.this.identity[0].tenant_id
  object_id    = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover"
  ]
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity.0.object_id
  role_definition_name = "AcrPull"
}


resource "local_file" "kubeconfig" {
  content  = azurerm_kubernetes_cluster.this.kube_config_raw
  filename = "./kubeconfig.yaml"
}
