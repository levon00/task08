locals {
  acr_name           = replace("${var.name_prefix}-cr", "-", "")
  rg_name            = "${var.name_prefix}-rg"
  aci_name           = "${var.name_prefix}-ci"
  acr_image_name     = "${var.name_prefix}-app"
  acr_container_name = "${var.name_prefix}-container"
  aks_name           = "${var.name_prefix}-aks"
  keyvault_name      = "${var.name_prefix}-kv"
  redis_name         = "${var.name_prefix}-redis"
}
