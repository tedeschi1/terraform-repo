variable "vmsubnetname" {
    type = string
    description = "Name of VM Subnet"
    default = "be-subnet"
}

variable "vmvnetname" {
    description = "Name of VM VNET"
    type = string
    default = "vnet1"
}

variable "vnetresourcegroup" {
    description = "Name of VNET RG"
    type = string
    default = "rg-vnet"
  
}

variable "vmresourcegroup" {
    description = "Name of VM RG"
    type = string
    default = "rg-vm"
}