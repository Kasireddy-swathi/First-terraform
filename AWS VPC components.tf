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
#NACL
resource "aws_network_acl" "NACL" {
  vpc_id = aws_vpc.VPC-02.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "NACL"
  }
}
#Security group
resource "aws_security_group" "security_group" {
  name        = "SSH and mysql"
  description = "Allow SSH and mysql inbound traffic"
  vpc_id      = aws_vpc.VPC-02.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

ingress {
    description      = "MYSQL from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Securitygp"
  }
}