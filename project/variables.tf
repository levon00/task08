variable "name_prefix" {
  description = "A prefix used for all resources"
  type        = string
}

variable "location" {
  description = "The location/region where all resources will be deployed"
  type        = string
}

variable "context_path" {
  description = "The path to the context of the Dockerfile"
  type        = string

}
variable "git_pat" {
  description = "The personal access token for the Git repository"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
}

# Redis

variable "redis_capacity" {
  description = "The size of the Redis cache to deploy"
  type        = number
}

variable "redis_sku" {
  description = "The SKU of the Redis cache to deploy"
  type        = string
}

variable "redis_sku_family" {
  description = "The SKU family of the Redis cache to deploy"
  type        = string
}

variable "redis_cache_port" {
  description = "The port of the Redis cache to deploy"
  type        = string
}

# Key Vault

variable "keyvault_sku" {
  description = "The SKU of the Key Vault to deploy"
  type        = string
}

variable "redis_password_secret_name" {
  description = "The primary key of the Redis cache"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "The hostname of the Redis cache"
  type        = string
}

# ACR

variable "acr_sku" {
  description = "The SKU of the Azure Container Registry to deploy"
  type        = string
}

# ACI

variable "aci_sku" {
  description = "The SKU of the Azure Container Instance to deploy"
  type        = string
}

variable "aci_env_vars" {
  description = "A map of environment variables to set on the Azure Container Instance"
  type        = map(string)
}

# AKS

variable "aks_node_pool_name" {
  description = "The name of the AKS node pool"
  type        = string
}

variable "aks_node_pool_count" {
  description = "The number of nodes in the AKS node pool"
  type        = number
}

variable "aks_node_pool_size" {
  description = "The size of the AKS node pool"
  type        = string
}

variable "aks_node_pool_disk_type" {
  description = "The disk type of the AKS node pool"
  type        = string
}
