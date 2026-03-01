variable "name" {
  type        = string
  description = "name of key vault"
}
variable "location" {
  type        = string
  description = "location of key vault"
}
variable "rg_name" {
  type        = string
  description = "name of resource group"
}
variable "tenant_id" {
  type        = string
  description = "tenant id for key vault"
}
variable "sku_name" {
  type        = string
  description = "sku of key vault"
}
variable "object_id" {
  type        = string
  description = "object id for key vault access policy"
}
variable "tags" {
  type        = map(string)
  description = "tags for key vault"
}