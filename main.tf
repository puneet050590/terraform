# Create a VPC
resource "aws_vpc" "test01" {
  cidr_block = "192.168.1.0/24"  
}