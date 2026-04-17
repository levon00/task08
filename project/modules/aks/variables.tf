variable "name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The location/region where the AKS cluster will be deployed."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group that will contain the AKS cluster."
  type        = string
}

variable "node_pool_name" {
  description = "The name of the node pool within the AKS cluster."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the node pool."
  type        = number
}

variable "vm_size" {
  description = "The size of the virtual machines in the node pool."
  type        = string
}

variable "disk_type" {
  description = "The type of disk to use for the virtual machines in the node pool."
  type        = string
}
variable "acr_id" {
  description = "The ID of the Azure Container Registry."
  type        = string
}

variable "kv_id" {
  description = "The ID of the Key Vault."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A map of tags for the resource."
}

