name_prefix      = "cmtr-0sj5vwga-mod8"
redis_cache_port = 6380

location = "East US"

context_path = "https://github.com/levon00/task08#main:task08/application"

aci_env_vars = {
  CREATOR        = "ACI"
  REDIS_PORT     = "6380"
  REDIS_SSL_MODE = true
}

redis_capacity   = 2
redis_sku        = "Basic"
redis_sku_family = "C"

keyvault_sku = "standard"

redis_password_secret_name = "redis-primary-key"
redis_hostname_secret_name = "redis-hostname"

acr_sku = "Basic"
aci_sku = "Standard"

aks_node_pool_name      = "system"
aks_node_pool_count     = 1
aks_node_pool_size      = "Standard_D2ads_v6"
aks_node_pool_disk_type = "Ephemeral"


tags = {
  "Creator" = "levon_khalatyan@epam.com"
}
