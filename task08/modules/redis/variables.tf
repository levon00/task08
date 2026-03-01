variable "name" {
  type        = string
  description = "name of redis cache"
}
variable "location" {
  type        = string
  description = "location of redis cache"
}
variable "rg_name" {
  type        = string
  description = "name of resource group"
}
variable "capacity" {
  type        = number
  description = "capacity of redis cache"
}
variable "family" {
  type        = string
  description = "family of redis cache"
}
variable "sku_name" {
  type        = string
  description = "sku of redis cache"
}
variable "key_vault_id" {
  type        = string
  description = "key vault id"
}
variable "redis_hostname_secret_name" {
  type        = string
  description = "secret name for redis hostname"
}
variable "secret_name_redis_key" {
  type        = string
  description = "secret name for redis key"
}
variable "tags" {
  type        = map(string)
  description = "tags for redis cache"
}