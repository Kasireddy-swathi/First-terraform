#create VPC
resource "aws_vpc" "VPC-02" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "VPC"
  }
}
