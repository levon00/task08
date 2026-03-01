resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.sku

  tags = var.tags
}


resource "azurerm_container_registry_task" "this" {
  name                  = "${var.name}-task"
  container_registry_id = azurerm_container_registry.this.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.context_path
    context_access_token = var.git_pat
    image_names          = ["${var.image_name}:v1"]
  }
}


resource "azurerm_container_registry_task_schedule_run_now" "this" {
  container_registry_task_id = azurerm_container_registry_task.this.id
}


resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = var.rg_name
  location            = var.location
  name                = "TaskIdentity"

  depends_on = [azurerm_container_registry_task_schedule_run_now.this]
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.this.id
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  role_definition_name = "AcrPull"
}
