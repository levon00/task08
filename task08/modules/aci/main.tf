resource "azurerm_container_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  dns_name_label      = "dns-${var.name}"
  ip_address_type     = "Public"
  os_type             = "Linux"
  sku                 = var.sku

  tags = var.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  image_registry_credential {
    server                    = var.acr_server
    user_assigned_identity_id = var.identity_id

  }

  container {
    name  = var.container_name
    image = "${var.acr_server}/${var.image}"

    cpu    = "0.5"
    memory = "1.5"

    environment_variables = var.env_vars


    secure_environment_variables = {
      REDIS_URL = data.azurerm_key_vault_secret.redis_hostname.value
      REDIS_PWD = data.azurerm_key_vault_secret.redis_password.value
    }

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}

data "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  key_vault_id = var.keyvault_id
}

data "azurerm_key_vault_secret" "redis_password" {
  name         = var.redis_password_secret_name
  key_vault_id = var.keyvault_id
}


