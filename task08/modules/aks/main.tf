resource "azurerm_kubernetes_cluster" "kube" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.name

  default_node_pool {
    name            = var.node_pool_name
    node_count      = var.node_count
    vm_size         = var.node_size
    os_disk_type    = var.os_disk_type
    os_disk_size_gb = 60
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                            = var.container_registry_id
  role_definition_name             = "Contributor"
  principal_id                     = azurerm_kubernetes_cluster.kube.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_key_vault_access_policy" "access_policy" {
  key_vault_id       = var.key_vault_id
  tenant_id          = var.tenant_id
  object_id          = azurerm_kubernetes_cluster.kube.key_vault_secrets_provider[0].secret_identity[0].object_id
  secret_permissions = ["Get", "List"]
}