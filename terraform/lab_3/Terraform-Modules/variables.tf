variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnet_1_cidr_block" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "subnet_2_cidr_block" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.1.2.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

