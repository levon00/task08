variable "name" {
  description = "The name of the Azure Container Registry"
  type        = string

}

variable "rg_name" {
  description = "The name of the resource group in which to create the Azure Container Registry"
  type        = string
}

variable "location" {
  description = "The location in which to create the Azure Container Registry"
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry"
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
  type        = map(string)
  description = "A map of tags for the resource."
}
variable "image_name" {
  description = "The name of the image to build"
  type        = string
}
