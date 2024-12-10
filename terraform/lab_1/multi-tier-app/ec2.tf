resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.app_subnet.id
  associate_public_ip_address = true  # This ensures the EC2 instance gets a public IP
  tags = {
    Name = "App-Server"
  }

  # Local provisioner to write the EC2 IP to a file
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ec2-ip.txt"
  }
}

