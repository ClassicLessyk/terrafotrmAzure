resource "azurerm_virtual_network" "kanboard_vnet" {
  name                = var.vnet_name
  address_space       = ["10.1.0.0/27"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "database_subnet" {
  name                 = var.db_subnet_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.kanboard_vnet.name
  address_prefixes     = ["10.1.0.0/28"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "kanboard_dns" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = var.virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.kanboard_dns.name
  virtual_network_id    = azurerm_virtual_network.kanboard_vnet.id
  resource_group_name   = azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "app_subnet" {
  name                 = var.app_subnet_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.kanboard_vnet.name
  address_prefixes     = ["10.1.0.16/28"]

  delegation {
    name = "webapp"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}