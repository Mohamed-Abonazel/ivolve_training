# Fetch existing VPC
data "aws_vpc" "ivolve-vpc" {
  filter {
    name   = "tag:Name"
    values = ["ivolve-vpc"]
  }
}

# Application Subnet
resource "aws_subnet" "app_subnet" {
  vpc_id            = data.aws_vpc.ivolve-vpc.id
  cidr_block        = var.app_subnet_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "App-Subnet"
  }
}

# Database Subnet A
resource "aws_subnet" "db_subnet_a" {
  vpc_id            = data.aws_vpc.ivolve-vpc.id
  cidr_block        = var.db_subnet_a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "DB-Subnet-A"
  }
}

# Database Subnet B
resource "aws_subnet" "db_subnet_b" {
  vpc_id            = data.aws_vpc.ivolve-vpc.id
  cidr_block        = var.db_subnet_b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "DB-Subnet-B"
  }
}



