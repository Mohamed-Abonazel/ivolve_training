# Create the VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Create the Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-route-table"
  }
}

# Create the Route for Internet Access
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Create Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_1_cidr_block
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true  # Automatically assign public IPs to instances launched here

  tags = {
    Name = "public-subnet-1"
  }
}

# Create Subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_2_cidr_block
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true  # Automatically assign public IPs to instances launched here

  tags = {
    Name = "public-subnet-2"
  }
}

# Associate the Route Table with Subnet 1
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate the Route Table with Subnet 2
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Call EC2 Module for Subnet 1
module "ec2_instance_1" {
  source        = "./modules/ec2"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_1.id
  vpc_id        = aws_vpc.main.id
  name          = "instance1"            # Unique name for the first EC2 instance
}

# Call EC2 Module for Subnet 2
module "ec2_instance_2" {
  source        = "./modules/ec2"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_2.id
  vpc_id        = aws_vpc.main.id
  name          = "instance2"            # Unique name for the second EC2 instance
}


