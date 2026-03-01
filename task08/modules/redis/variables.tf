variable "name" {
  description = "The name of the Redis instance"
  type        = string
}

variable "location" {
  description = "The location/region where the Redis instance will be deployed"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "capacity" {
  description = "The capacity of the Redis instance"
  type        = number
}

variable "family" {
  description = "The family of the Redis cache"
  type        = string
}

variable "sku" {
  description = "The SKU of the Redis instance"
  type        = string
}


variable "redis_hostname_secret_name" {
  description = "The secret name for the Redis hostname in Key Vault"
  type        = string
}

variable "redis_password_secret_name" {
  description = "The secret name for the Redis primary key in Key Vault"
  type        = string
}

variable "kv_id" {
  description = "The ID of the Key Vault"
  type        = string

}

variable "tags" {
  type        = map(string)
  description = "A map of tags for the resource."
}
