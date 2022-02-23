provider "azurerm" {
  features {}
}

# refer to a resource group
data "azurerm_resource_group" "rg-nsg" {
  name = var.vnetresourcegroup
}

data "azurerm_subnet" "vm-subnet" {
  name                 = var.nsgsubnetname
  virtual_network_name = var.nameofvnet
  resource_group_name  = var.vnetresourcegroup
}

resource "azurerm_network_security_group" "nsg-vm" {
  name                = "nsg-inbound"
  location            = data.azurerm_resource_group.rg-nsg.location
  resource_group_name = data.azurerm_resource_group.rg-nsg.name

  security_rule {
    name                       = "rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.nsgline100sourceaddress
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-vm" {
  subnet_id                 = "${data.azurerm_subnet.vm-subnet.id}"
  network_security_group_id = azurerm_network_security_group.nsg-vm.id
}