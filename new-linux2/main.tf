provider "azurerm" {
  features {}
}

#this can be removed
# refer to a resource group
data "azurerm_resource_group" "rg-vm" {
  name = var.vmresourcegroup
}

#refer to a subnet
data "azurerm_subnet" "subnet" {
  name                 = var.vmsubnetname
  virtual_network_name = var.vmvnetname
  resource_group_name  = var.vnetresourcegroup
}

# create a network interface
resource "azurerm_network_interface" "test" {
  name                = "nic-test"
  location            = "${data.azurerm_resource_group.rg-vm.location}"
  resource_group_name = "${data.azurerm_resource_group.rg-vm.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${data.azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.public_ip.id}"
   }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip_tedeschi"
  location            = "${data.azurerm_resource_group.rg-vm.location}"
  resource_group_name = "${data.azurerm_resource_group.rg-vm.name}"
  allocation_method   = "Dynamic"
}

# Create virtual machine
resource "azurerm_virtual_machine" "test" {
    name                  = "vm-linux1"
    location              = "${azurerm_network_interface.test.location}"
    resource_group_name   = "${data.azurerm_resource_group.rg-vm.name}"
    network_interface_ids = "${azurerm_network_interface.test.id}"
    vm_size               = "Standard_DS1_v2"

# Uncomment this line to delete the OS disk automatically when deleting the VM
delete_os_disk_on_termination = true

# Uncomment this line to delete the data disks automatically when deleting the VM
delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
   storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
   os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
   os_profile_linux_config {
    disable_password_authentication = false
  }

}