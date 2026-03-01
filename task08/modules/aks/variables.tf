variable "name" {
  type        = string
  description = "name of aks cluster"
}
variable "location" {
  type        = string
  description = "location of aks cluster"
}
variable "rg_name" {
  type        = string
  description = "name of resource group"
}
variable "node_pool_name" {
  type        = string
  description = "name of node pool"
}
variable "node_count" {
  type        = number
  description = "number of nodes in node pool"
}
variable "node_size" {
  type        = string
  description = "size of nodes in node pool"
}
variable "os_disk_type" {
  type        = string
  description = "os disk type for nodes in node pool"
}
variable "tags" {
  type        = map(string)
  description = "tags for all resources"
}
variable "container_registry_id" {
  type        = string
  description = "id of container registry"
}
variable "key_vault_id" {
  type        = string
  description = "id of key vault"
}
variable "tenant_id" {
  type        = string
  description = "tenant id"
}
  