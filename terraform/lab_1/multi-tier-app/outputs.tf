output "vpc_id" {
  description = "The ID of the manually created VPC"
  value       = data.aws_vpc.ivolve-vpc.id
}

output "ec2_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.db_instance.endpoint
}


