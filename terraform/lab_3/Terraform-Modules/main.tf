resource "aws_instance" "nginx_server" {
  ami           = "ami-0e2c8caa4b6378d8c"  # Ubuntu AMI ID (change based on your region)
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]


  tags = {
    Name = var.name
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
}

resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg_${var.name}"     # Add a unique suffix using the instance name
  description = "Allow HTTP and SSH traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value = aws_instance.nginx_server.public_ip
}


