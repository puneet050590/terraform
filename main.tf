terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
        }
  }

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "test01" {
  cidr_block = "192.168.1.0/24"  
}