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
    default = "rg-vnet171"
}


variable "nameofvnet" {
    description = "Name of VNET to Be Created"
    type = string
    default = "vnet171"
}