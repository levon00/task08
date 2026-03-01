variable "name" {
  type        = string
  description = "The name of the resource."
}

variable "location" {
  type        = string
  description = "The location where the resource will be created."
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group."
}

variable "container_name" {
  type        = string
  description = "The name of the container."
}

variable "image" {
  type        = string
  description = "The container image to use."
}

variable "env_vars" {
  type        = map(string)
  description = "A map of environment variables for the container."
}

variable "redis_hostname_secret_name" {
  type        = string
  description = "The hostname of the Redis instance."
}

variable "redis_password_secret_name" {
  type        = string
  description = "The primary key for the Redis instance."
}

variable "keyvault_id" {
  type        = string
  description = "The ID of the Key Vault."

}

variable "sku" {
  type        = string
  description = "The SKU of the resource."
}

variable "acr_server" {
  type        = string
  description = "The server URL of the Azure Container Registry."
}
variable "identity_id" {
  type        = string
  description = "The ID of the user-assigned identity."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags for the resource."
}