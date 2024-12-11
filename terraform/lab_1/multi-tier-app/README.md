# Lab 1: Multi-Tier Application Deployment with Terraform

## Objective
The goal of this lab is to deploy a **multi-tier application architecture** on AWS using Terraform. The architecture includes a VPC, two subnets (application and database), an EC2 instance (application server), and an RDS instance (database server). Additionally, we use a **local provisioner** to save the EC2 instance's public IP to a file.

## Lab Requirements
1. **AWS Account** with appropriate permissions.
2. **Terraform** installed on your local machine.
3. **Basic knowledge** of Terraform and AWS resources.

## Architecture Overview
The architecture deployed in this lab consists of:
- **VPC**: Created manually in AWS (Name: `ivolve`), and its ID is retrieved using Terraform's Data Block.
- **Subnets**:
  - Application Subnet: To host the EC2 instance (app server).
  - Database Subnet: To host the RDS instance (database server).
- **EC2 Instance**:
  - Acts as the application server.
  - The public IP of the instance is written to a file `ec2-ip.txt` using the **local-exec provisioner**.
- **RDS Instance**:
  - Acts as the database backend.
  - Uses a **DB Subnet Group** to ensure it runs in the database subnet.

## Steps to Deploy the Lab

### Step 1: Create the VPC Manually
1. Log in to your **AWS Management Console**.
2. Go to **VPC Dashboard** > **Create VPC**.
3. Create a VPC with the following details:
   - **Name**: `ivolve`
   - **CIDR Block**: `10.0.0.0/16`
4. Note the VPC ID for reference.

### Step 2: Terraform Configuration

#### 2.1. File Structure
Organize the Terraform files as follows:
```plaintext
.
|-- ec2.tf          # ec2 configuration for resources
|-- rds.tf          # rds configuration for resources
|-- terraform.tfvars
|-- vpc.tf          # vpc configuration for resources
|-- variables.tf    # Input variables
|-- outputs.tf      # Output values
|-- provider.tf     # AWS provider configuration
|-- ec2-ip.txt      # Local file to store EC2 public IP (generated after apply)
```

#### 2.2. `provider.tf`
Configure the Terraform provider for AWS:
```hcl
provider "aws" {
  region = "us-east-1" # Change this to your desired region
}
```

#### 2.3. `main.tf`
Define the main resources:

```hcl
# Data Block to fetch the existing VPC ID
data "aws_vpc" "ivolve_vpc" {
  filter {
    name   = "tag:Name"
    values = ["ivolve"]
  }
}

# Create Subnets
resource "aws_subnet" "app_subnet" {
  vpc_id            = data.aws_vpc.ivolve_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "App-Subnet"
  }
}

resource "aws_subnet" "db_subnet" {
  vpc_id            = data.aws_vpc.ivolve_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "DB-Subnet"
  }
}

# EC2 Instance
resource "aws_instance" "app_server" {
  ami           = "ami-0e2c8caa4b6378d8c" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.app_subnet.id

  tags = {
    Name = "App-Server"
  }

  # Local provisioner to write EC2 public IP to a file
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ec2-ip.txt"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.db_subnet.id]

  tags = {
    Name = "DB-Subnet-Group"
  }
}

# RDS Instance
resource "aws_db_instance" "db_instance" {
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0.35"
  instance_class          = "db.t2.micro"
  db_name                 = "ivolvedb"
  username                = "admin"
  password                = "password123"
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot     = true

  tags = {
    Name = "DB-Instance"
  }
}
```

#### 2.4. `variables.tf`
Define input variables:
```hcl
variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}
```

#### 2.5. `outputs.tf`
Output key details after deployment:
```hcl
output "ec2_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.db_instance.endpoint
}
```

### Step 3: Deploy the Infrastructure
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Plan the Deployment**:
   ```bash
   terraform plan
   ```
3. **Apply the Configuration**:
   ```bash
   terraform apply
   ```
   Confirm the deployment by typing `yes`.

### Step 4: Verify the Outputs
After deployment, Terraform will output the following:
- **EC2 Public IP**: Public IP address of the EC2 instance.
- **RDS Endpoint**: Endpoint URL of the RDS database.

You can also check the `ec2-ip.txt` file on your local machine for the EC2 instance's public IP.

### Step 5: Clean Up Resources
To delete all resources created by Terraform, run:
```bash
terraform destroy
```
Confirm the destruction by typing `yes`.

## Lab Outcomes
By the end of this lab, you will:
1. Understand how to retrieve manually created AWS resources (e.g., VPC) using Terraform's **data blocks**.
2. Deploy a **multi-tier architecture** with EC2 and RDS using Terraform.
3. Use **local-exec provisioners** to interact with local files.
4. Output critical information (e.g., EC2 IP, RDS Endpoint) for verification.

## Notes
- Replace the AMI ID with one suitable for your AWS region.
- Ensure you have the correct permissions for creating EC2 and RDS resources.

## Diagram (Optional)
If needed, draw a basic diagram showing the VPC, subnets, EC2 instance, and RDS database placement.

---

**Congratulations! You have successfully deployed a multi-tier application architecture using Terraform.**
