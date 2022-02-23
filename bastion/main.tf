provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-bastion" {
  name     = var.bastionresourcegroupname
  location = var.bastionlocation
}

data "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  resource_group_name = "rg-vnet"
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.vnet.id
}

resource "azurerm_subnet" "sn-bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = "${data.azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${data.azurerm_virtual_network.vnet.name}"
  address_prefixes     = ["10.0.255.0/27"]
}

resource "azurerm_public_ip" "pip-bastion" {
  name                = "pip-bastion"
  location            = azurerm_resource_group.rg-bastion.location
  resource_group_name = azurerm_resource_group.rg-bastion.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "Bastion"
  location            = azurerm_resource_group.rg-bastion.location
  resource_group_name = azurerm_resource_group.rg-bastion.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.sn-bastion.id
    public_ip_address_id = azurerm_public_ip.pip-bastion.id
  }
}