resource "azurerm_service_plan" "webapp_plan" {
  name                = var.webapp_plan_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "kanboard_terraform" {
  name                = var.webapp_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_service_plan.webapp_plan.location
  service_plan_id     = azurerm_service_plan.webapp_plan.id

  site_config {
    application_stack {
      php_version = "7.4"
    }
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "webapp_vnet" {
  app_service_id = azurerm_linux_web_app.kanboard_terraform.id
  subnet_id      = azurerm_subnet.app_subnet.id
}