# vm creation in azure


# Variables
variable "resource_group" {}
variable "location" {}
variable "vm_name" {}
variable "admin_user" {}

resource "azurerm_resource_group" "rg" {
   name     = var.resource_group
   location = var.location
}
# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "testvnet01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["192.168.1.0/24"]
}
resource "azurerm_subnet" "subnet1" {
    name                = "testsubnet1"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes    = ["192.168.1.0/25"]
    }
    
resource "azurerm_subnet" "subnet2" {
    name             = "testsubnet2"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["192.168.1.128/25"]
}

/*
# Create Public IP
resource "azurerm_public_ip" "pubip" {
  name                = "testpubip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}*/
# Create Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "testnic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testsubnet2"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "nic1" {
  name                = "testnic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testsubnet1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Deploy Linux Virtual Machine
resource "azurerm_virtual_machine" "VM" {
  name                  = var.vm_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
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
    admin_username = "puneet"
    admin_password = "Symbotic12#$"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Deploy Linux Virtual Machine
resource "azurerm_virtual_machine" "VM01" {
  name                  = "testVM01"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic1.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "puneet"
    admin_password = "Symbotic12#$"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

/*
# Create a VPC
resource "aws_vpc" "test01" {
  cidr_block = "192.168.1.0/24"  
}
resource "google_compute_network" "vpc_network" {
  name = "test01"
}
*/