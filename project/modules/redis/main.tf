resource "azurerm_redis_cache" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku

  tags = var.tags
}


resource "azurerm_key_vault_secret" "primery_key" {
  name         = var.redis_password_secret_name
  value        = azurerm_redis_cache.this.primary_access_key
  key_vault_id = var.kv_id
}


resource "azurerm_key_vault_secret" "hostanme" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_redis_cache.this.hostname
  key_vault_id = var.kv_id
}
