variable "name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "location" {
  description = "The location/region where the Key Vault will be created."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group that will contain the Key Vault."
  type        = string
}

variable "sku" {
  description = "The SKU (pricing tier) of the Key Vault."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A map of tags for the resource."
}
