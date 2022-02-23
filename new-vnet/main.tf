provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-vnet" {
  name     = "rg-vnet"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.nameofvnet
  location            = azurerm_resource_group.rg-vnet.location
  resource_group_name = azurerm_resource_group.rg-vnet.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = var.nameofsubnet1
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = var.nameofsubnet2
    address_prefix = "10.0.2.0/24"
  }

  tags = {
    environment = "Production"
  }
}