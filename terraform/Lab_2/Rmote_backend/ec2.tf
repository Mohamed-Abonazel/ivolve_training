# ec2.tf

resource "aws_instance" "my_ec2" {
  ami             = var.ami_id  # Replace with your valid AMI ID
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.allow_ssh_http.id]

  # Automatically associate a public IP
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true  # Ensures new instance is created before old one is destroyed
  }

 depends_on = [aws_security_group.allow_ssh_http]

}


