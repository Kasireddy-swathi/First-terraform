#delete vpc
resource "aws_vpc" "VPC-01" {
  force_destroy = true
}