# Lab 19: Remote Backend and LifeCycle Rules

## Overview
This lab demonstrates how to implement infrastructure as code (IaC) using **Terraform** with the following requirements:

1. **Infrastructure Components**:
   - VPC
   - Subnet
   - EC2 instance with a Security Group
   - Internet Gateway
   - CloudWatch Integration
   - SNS (Simple Notification Service) email notification (to Gmail)
2. **Remote Backend**:
   - Store the Terraform state file remotely in an S3 bucket.
   - Use DynamoDB for state locking to avoid conflicts.
3. **Lifecycle Rules**:
   - Implement `create_before_destroy` lifecycle rule on the EC2 instance.
   - Compare the behavior of different lifecycle rules.

## Prerequisites
Before starting this lab, ensure the following tools and services are set up:

1. **AWS CLI** installed and configured with your credentials:
   ```bash
   aws configure
   ```
2. **Terraform** installed (v1.0 or above).
3. **AWS Resources**:
   - An S3 bucket for storing the remote Terraform state.
   - A DynamoDB table for state locking.
4. Basic knowledge of Terraform and AWS services.

---

## Project Structure
The lab is organized into the following files:

```plaintext
.
|-- main.tf                # Root Terraform configuration file
|-- variables.tf           # Input variables definition
|-- outputs.tf             # Output values
|-- providers.tf           # Provider and backend configuration
|-- ec2.tf                 # EC2 instance with lifecycle rules
|-- network.tf             # VPC, Subnet, Internet Gateway
|-- security_group.tf      # Security Group rules
|-- cloudwatch_sns.tf      # CloudWatch and SNS configuration
|-- terraform.tfvars       # Variable values
|-- README.md              # Documentation for the lab
```

---

## Steps to Implement the Lab

### 1. Clone the Repository
Clone the Terraform configuration files or create the above project structure in your directory:

```bash
git clone <repo-url>
cd Lab19_Remote_Backend_Lifecycle
```

### 2. Configure the Remote Backend
In `providers.tf`, configure the **S3 bucket** for the backend and **DynamoDB** for state locking:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "env:/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```
- Replace `your-terraform-state-bucket` with your S3 bucket name.
- Ensure the `dynamodb_table` exists.

### 3. Initialize Terraform
Run the following command to initialize the backend and download required providers:

```bash
terraform init
```

### 4. Apply the Configuration
To create the infrastructure, execute:

```bash
terraform apply
```

- Terraform will store the state file in the remote S3 bucket.
- You will see the resources being created in AWS.

### 5. Verify `create_before_destroy` Lifecycle Rule
The EC2 instance has the `create_before_destroy` rule enabled in `ec2.tf`:

```hcl
resource "aws_instance" "my_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.allow_ssh_http.name]

  lifecycle {
    create_before_destroy = true
  }
}
```

- **Test**: Modify the instance type in `variables.tfvars`.
- Run `terraform apply`.
- Observe that Terraform creates a new EC2 instance **before** destroying the old one.

### 6. Test SNS Email Notifications
- Check your **Gmail inbox** to ensure SNS email notifications are working.
- If you do not see an email, verify the SNS subscription status in the AWS Console.

### 7. Compare Lifecycle Rules
| Lifecycle Rule           | Description                                    |
|--------------------------|------------------------------------------------|
| `create_before_destroy`  | Creates a new resource before deleting the old one. |
| `prevent_destroy`        | Prevents a resource from being destroyed.      |
| `ignore_changes`         | Ignores specific changes in resource arguments.|

To test other lifecycle rules:
1. Replace `create_before_destroy` with other rules in the `ec2.tf` file.
2. Re-run `terraform apply` and observe the behavior.

### 8. Destroy the Infrastructure
To clean up all resources:

```bash
terraform destroy
```

Ensure the **S3 bucket** and DynamoDB table remain intact, as they store your state file and lock information.

---

## Screenshots to Include

1. **S3 State File**:
   - Go to AWS Console → **S3** → Open the specified bucket.
   - Verify the `terraform.tfstate` file is stored correctly.

2. **DynamoDB State Lock**:
   - Go to AWS Console → **DynamoDB** → Table → Check the active state lock during apply.

3. **EC2 Lifecycle Rule - `create_before_destroy`**:
   - Update a resource and run `terraform apply`.
   - Show Terraform creating a new resource before destroying the old one.

4. **CloudWatch and SNS**:
   - Verify CloudWatch alarms and received SNS emails.

5. **Terraform Output**:
   - Display the Terraform outputs after apply.

6. **Destroy Confirmation**:
   - Show Terraform output confirming resource deletion.

---

## Verification Checklist
Use the following checklist to verify the lab:

1. ✅ State file is stored in the S3 bucket.
2. ✅ DynamoDB table is used for state locking.
3. ✅ EC2 instance is created with `create_before_destroy` lifecycle rule.
4. ✅ VPC, Subnet, and Security Group are properly configured.
5. ✅ CloudWatch is sending notifications via SNS to Gmail.
6. ✅ Infrastructure can be destroyed without issues.

---

## Clean Up
After verifying the lab, ensure you clean up the resources to avoid unnecessary costs:

```bash
terraform destroy
```

---

## Notes
- Always use version-controlled Terraform configurations.
- Ensure IAM roles have sufficient permissions to manage S3, DynamoDB, EC2, and other AWS resources.

---

## References
- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS S3 Backend](https://www.terraform.io/language/settings/backends/s3)
- [Terraform Lifecycle Rules](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

