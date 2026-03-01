data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

module "acr" {
  source        = "./modules/acr"
  name          = local.acr_name
  location      = var.location
  rg_name       = azurerm_resource_group.rg.name
  sku           = var.sku[0]
  img_task_name = format("%s-img-task", local.acr_name)
  git_pat       = var.git_pat
  image_name    = local.docker_img_name
  tags          = var.tags
}

module "keyvault" {
  source    = "./modules/keyvault"
  name      = local.keyvault_name
  location  = var.location
  rg_name   = azurerm_resource_group.rg.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
  sku_name  = var.sku[1]
  tags      = var.tags
}

module "redis" {
  source                     = "./modules/redis"
  name                       = local.redis_name
  location                   = var.location
  rg_name                    = azurerm_resource_group.rg.name
  capacity                   = var.redis_capacity
  family                     = var.redis_sku_family
  sku_name                   = var.sku[0]
  key_vault_id               = module.keyvault.key_vault_id
  redis_hostname_secret_name = var.secret_name_redis_hostname
  secret_name_redis_key      = var.secret_name_redis_key
  tags                       = var.tags
  depends_on                 = [module.keyvault]
}

module "aci" {
  source               = "./modules/aci"
  name                 = local.aci_name
  location             = var.location
  rg_name              = azurerm_resource_group.rg.name
  container_name       = format("%s-container", local.aci_name)
  sku                  = var.sku[2]
  dns_name_label       = format("%s-dns", local.aci_name)
  login_server         = module.acr.acr_login_server
  docker_image         = local.docker_img_name
  redis_hostname_value = module.redis.redis_hostname
  redis_key_value      = module.redis.redis_key
  admin_username       = module.acr.admin_username
  admin_password       = module.acr.admin_password
  tags                 = var.tags
  depends_on           = [module.acr, module.redis]
}

module "aks" {
  source                = "./modules/aks"
  name                  = local.aks_name
  location              = var.location
  rg_name               = azurerm_resource_group.rg.name
  node_pool_name        = var.aks_node_pool_name
  node_count            = var.aks_node_pool_count
  node_size             = var.aks_node_pool_size
  os_disk_type          = var.aks_node_pool_os_disk_type
  container_registry_id = module.acr.acr_id
  key_vault_id          = module.keyvault.key_vault_id
  tenant_id             = data.azurerm_client_config.current.tenant_id
  tags                  = var.tags
  depends_on            = [azurerm_resource_group.rg, module.acr, module.keyvault]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    kv_name                    = module.keyvault.key_vault_name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
    redis_url_secret_name      = module.redis.redis_hostname
    redis_password_secret_name = module.redis.redis_key
    aks_kv_access_identity_id  = module.aks.secrets_provider_client_id
  })
  depends_on = [module.aks]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = local.docker_img_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }
  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service" "app_service" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }
  depends_on = [kubectl_manifest.service]
}