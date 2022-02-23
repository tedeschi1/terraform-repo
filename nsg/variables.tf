variable "nameofsubnet1" {
    type = string
    description = "Name of Subnet1"
    default = "fe-subnet"
}

variable "nameofsubnet2" {
    description = "Name of Subnet2"
    type = string
    default = "be-subnet"
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

variable "nameofvnet" {
    description = "Name of VNET to Be Created"
    type = string
    default = "vnet1"
}

variable "nsgsubnetname" {
    description = "Name of Subnet to Attach NSG to"
    default = "be-subnet"
  
}

variable "nsgline100sourceaddress" {
    description = "NSG Line 100 Source Address"
    type = string
    default = "47.186.0.0/16"
}