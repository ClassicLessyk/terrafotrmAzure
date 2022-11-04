resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                   = var.mysql_server_name
  resource_group_name    = azurerm_resource_group.resource_group.name
  location               = azurerm_resource_group.resource_group.location
  administrator_login    = var.db_admin_login
  administrator_password = var.db_admin_password
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.database_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.kanboard_dns.id
  sku_name               = "B_Standard_B1s"

  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_link]
  storage {
    size_gb = 20
    iops = 360
  }
}

resource "azurerm_mysql_flexible_server_configuration" "secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  value               = "OFF"
}