variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be deployed"
}

variable "vpc_id" {
  description = "The VPC ID for the security group"
}

variable "name" {
  description = "A unique name for the EC2 instance and its resources"
  type        = string
}



