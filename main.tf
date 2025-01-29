terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
    google = {
      source = "hashicorp/google"
      version = "6.17.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "dc8b8ab6-3e48-4de2-bd1f-0feeb24409c8"
}
provider "google" {
  # Configuration options
  project = "Terraform"
} 
# Create a VPC
resource "aws_vpc" "test01" {
  cidr_block = "192.168.1.0/24"  
}
# Create a resource group
#resource "azurerm_resource_group" "testTF01" {
#  name     = "example-resources"
#  location = "West Europe"
#}
resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
}
