#Create EC2 Server
resource "aws_instance" "Ec2" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  key_name = "Swathi-pem"
  user_data = file("Ecomm.sh")
  tags = {
    Name = "Ecomm-app"
  }
}

output "Ec2-pip" {
    value=["${aws_instance.Ec2.*.public_ip}"]
}

