# variables.tf

variable "aws_region" {
  description = "The AWS region where resources will be created"
  default     = "us-east-1"  # Replace with your desired region
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.5.0.0/16"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  default     = "10.5.1.0/24"
}

variable "instance_type" {
  description = "The type of EC2 instance"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-0e2c8caa4b6378d8c"  # Replace with a valid AMI ID
}

variable "sns_email" {
  description = "The email address to subscribe to the SNS topic"
  default     = "mohamedabonazel4@gmail.com"  # Replace with your Gmail address
}


