#create VPC
resource "aws_vpc" "VPC-02" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "VPC"
  }
}
#create subnet
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.VPC-02.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-01"
  }
}
#create internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.VPC-02.id

  tags = {
    Name = "ig-01"
  }
}
#create routetable
resource "aws_route_table" "Route_table" {
  vpc_id = aws_vpc.VPC-02.id

  tags = {
    Name = "rt-01"
  }
}
#routetable association
resource "aws_route_table_association" "route_table_association-01" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.Route_table.id
}
