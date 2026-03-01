variable "name" {
  type        = string
  description = "name of acr"
}
variable "location" {
  type        = string
  description = "location of all resource"
}
variable "rg_name" {
  type        = string
  description = "name of resource group"
}
variable "sku" {
  type        = string
  description = "sku of acr"
}
variable "img_task_name" {
  type        = string
  description = "name of image task"
}
variable "git_pat" {
  type        = string
  sensitive   = true
  description = "git access token"
}
variable "image_name" {
  type        = string
  description = "name of image"
}
variable "tags" {
  type        = map(string)
  description = "tags for all resources"
}