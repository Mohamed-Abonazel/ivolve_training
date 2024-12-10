
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0e2c8caa4b6378d8c" # Replace with valid AMI
}

variable "db_username" {
  description = "Username for RDS"
  default     = "admin"
}

variable "db_password" {
  description = "Password for RDS"
  sensitive   = true
}

variable "app_subnet_cidr" {
  description = "CIDR for application subnet"
  default     = "10.0.1.0/24"
}

variable "db_subnet_a_cidr" {
  description = "CIDR for first database subnet"
  default     = "10.0.2.0/24"
}

variable "db_subnet_b_cidr" {
  description = "CIDR for second database subnet"
  default     = "10.0.3.0/24"
}




