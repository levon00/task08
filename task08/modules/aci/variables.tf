variable "name" {
  type        = string
  description = "name of aci container group"
}
variable "location" {
  type        = string
  description = "location of aci container group"
}
variable "rg_name" {
  type        = string
  description = "name of resource group"
}
variable "container_name" {
  type        = string
  description = "name of container in aci container group"
}
variable "sku" {
  type        = string
  description = "sku of aci container group"
}
variable "dns_name_label" {
  type        = string
  description = "dns name label for aci container group"
}
variable "login_server" {
  type        = string
  description = "login server of container registry"
}
variable "docker_image" {
  type        = string
  description = "docker image for container in aci container group"
}
variable "redis_hostname_value" {
  type        = string
  description = "redis hostname value for environment variable in aci container group"
}
variable "redis_key_value" {
  type        = string
  description = "redis key value for environment variable in aci container group"
}
variable "admin_username" {
  type        = string
  description = "admin username for container registry"
}
variable "admin_password" {
  type        = string
  sensitive   = true
  description = "admin password for container registry"
}
variable "tags" {
  type        = map(string)
  description = "tags for all resources"
}