# state file


# Create a VPC
resource "aws_vpc" "test01" {
  cidr_block = "192.168.1.0/24"  
}
resource "azurerm_resource_group" "testrg01" {
  name     = "test01"
  location = "West Europe"
}
resource "google_compute_network" "vpc_network" {
  name = "test01"
}