resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

module "keyvault" {
  source   = "./modules/keyvault"
  name     = local.keyvault_name
  rg_name  = local.rg_name
  location = var.location
  sku      = var.keyvault_sku

  tags = var.tags


  depends_on = [azurerm_resource_group.rg]
}

module "redis" {
  source   = "./modules/redis"
  name     = local.redis_name
  rg_name  = local.rg_name
  location = var.location

  capacity = var.redis_capacity
  family   = var.redis_sku_family
  sku      = var.redis_sku

  kv_id                      = module.keyvault.kv_id
  redis_hostname_secret_name = var.redis_hostname_secret_name
  redis_password_secret_name = var.redis_password_secret_name


  tags = var.tags

  depends_on = [azurerm_resource_group.rg]
}


module "acr" {
  source   = "./modules/acr"
  name     = local.acr_name
  rg_name  = local.rg_name
  location = var.location
  sku      = var.acr_sku

  context_path = var.context_path
  git_pat      = var.git_pat
  image_name   = local.acr_image_name

  tags = var.tags


  depends_on = [azurerm_resource_group.rg]
}

module "aci" {
  source   = "./modules/aci"
  name     = local.aci_name
  rg_name  = local.rg_name
  location = var.location
  sku      = var.aci_sku

  image          = "${local.acr_image_name}:v1"
  acr_server     = module.acr.acr_login_server
  container_name = local.acr_container_name
  identity_id    = module.acr.identity_id

  keyvault_id = module.keyvault.kv_id

  redis_hostname_secret_name = var.redis_hostname_secret_name
  redis_password_secret_name = var.redis_password_secret_name


  env_vars = var.aci_env_vars

  tags = var.tags

  depends_on = [module.redis]
}

module "aks" {
  source = "./modules/aks"

  name     = local.aks_name
  rg_name  = local.rg_name
  location = var.location

  kv_id          = module.keyvault.kv_id
  acr_id         = module.acr.acr_id
  node_pool_name = var.aks_node_pool_name
  node_count     = var.aks_node_pool_count
  vm_size        = var.aks_node_pool_size
  disk_type      = var.aks_node_pool_disk_type

  tags = var.tags

  depends_on = [module.aci]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.kv_access_identity_id
    kv_name                    = local.keyvault_name
    redis_url_secret_name      = var.redis_hostname_secret_name
    redis_password_secret_name = var.redis_password_secret_name
    tenant_id                  = module.keyvault.tenant_id
    }
  )
  depends_on = [module.aks]
}


resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.secret_provider]
}


resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = local.acr_image_name
    image_tag        = "v1"
    }
  )

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }
  depends_on = [kubectl_manifest.service, kubectl_manifest.secret_provider]
}

data "kubernetes_service" "this" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.deployment]
}
