 terraform {
  required_version = ">= 0.11" 
 backend "azurerm" {
  storage_account_name = "__terraformstorageaccount__"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
	access_key  ="__storagekey__"
	}
	}
  provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "azureSQLTask" {
  name     = "azureSQL"
  location = "east us"
    
}

resource "azurerm_mssql_server" "azuresqlServerTask" {
  name                         = "task1azuresql"
  resource_group_name          = "${azurerm_resource_group.azureSQLTask.name}"
  location                     = "east us"
  vcores                       =  4
  administrator_login          = "__SQLServerAdminUser__"
  administrator_login_password = "__SQLServerAdminPassword__"
    
}

resource "azurerm_sql_database" "azuresqlServerDB" {
  name                = "sampleDB"
  resource_group_name = "${azurerm_resource_group.azureSQLTask.name}"
  location            = "east us"
  server_name         = "${azurerm_sql_server.azuresqlServerTask.name}"
  edition                          = "Basic"
 
 }
