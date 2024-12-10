# RDS Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db-subnet-group"
  subnet_ids  = [aws_subnet.db_subnet_a.id, aws_subnet.db_subnet_b.id]

  tags = {
    Name = "DB-Subnet-Group"
  }
}

# RDS Instance
resource "aws_db_instance" "db_instance" {
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0.39"
  instance_class          = "db.t3.micro"
  db_name                 = "ivolvedb"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot     = true

  tags = {
    Name = "DB-Instance"
  }
}

