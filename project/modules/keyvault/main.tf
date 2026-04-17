resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = var.sku
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover"
  ]
}