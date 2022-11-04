variable "location" {
    type = string
    description = "Location for the deployment"
}

variable "rgname" {
    type = string
    description = "Resource group name"
}

variable "webapp_plan_name" {
    type = string
    description = "Webapp plan name"
}

variable "webapp_name" {
    type = string
    description = "Webapp name"
}

variable "vnet_name" {
    type = string
    description = "Virtual network name"
}

variable "db_subnet_name" {
    type = string
    description = "Database subnet name"
}

variable "app_subnet_name" {
    type = string
    description = "Webapp subnet name"
}

variable "mysql_server_name" {
    type = string
    description = "Mysql database server name"
}

variable "db_admin_login" {
    type = string
    description = "Administrator login for Database"
}

variable "db_admin_password" {
    type = string
    description = "Administrator password for Database"
}

variable "private_dns_zone_name" {
    type = string
    description = "Private DNS zone name"
}

variable "virtual_network_link_name" {
    type = string
    description = "Virtual network link name"
}