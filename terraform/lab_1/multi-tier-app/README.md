# Terraform Project: Remote Backend, EC2, VPC, Security Groups, CloudWatch, and SNS Notifications

## Overview
This project demonstrates the use of **Terraform** to provision AWS resources with the following components:

1. **Remote Backend**
   - Store Terraform state files in an **S3 bucket**.
   - 
2. **Infrastructure Components**
   - VPC and Subnet.
   - EC2 Instance with lifecycle rules.
   - Internet Gateway for internet access.
   - Security Groups for SSH and HTTP access.
3. **CloudWatch and SNS Integration**
   - Monitor EC2 instance CPU usage.
   - Send email notifications using **SNS** when CPU utilization exceeds 80%.

---

## Project Structure
The project files are organized as follows:

```plaintext
.
|-- backend.tf            # S3 backend configuration
|-- cloudwatch.tf         # CloudWatch Alarm for CPU utilization
|-- ec2.tf                # EC2 instance creation with lifecycle rule
|-- internet_gateway.tf   # Internet Gateway for VPC
|-- outputs.tf            # Outputs for created resources
|-- security_group.tf     # Security Group for SSH and HTTP access
|-- sns.tf                # SNS Topic and email subscription
|-- variables.tf          # Variables for resource configurations
|-- vpc.tf                # VPC and Subnet configuration
|-- README.md             # Project documentation
```

---

## Prerequisites
Before starting, ensure the following:

1. **AWS CLI** is installed and configured:
   ```bash
   aws configure
   ```
2. **Terraform** is installed (v1.0 or higher).
3. An **S3 bucket** exists for storing Terraform state.
4. Replace placeholders like `bucket`, `ami_id`, and `sns_email` with your values.

---

## Steps to Deploy the Infrastructure

### 1. Configure the S3 Backend
Edit the `backend.tf` file and set the remote backend configuration:
```hcl
terraform {
  backend "s3" {
    bucket = "ivolve-s3"   # Replace with your S3 bucket name
    key    = "terraform/state.tfstate"
    region = "us-east-1"   # Replace with your AWS region
  }
}
```
Ensure that your S3 bucket and DynamoDB table are already created.

### 2. Initialize Terraform
Run the following command to initialize the backend and download required providers:
```bash
terraform init
```

### 3. Apply the Configuration
Deploy the resources with the following command:
```bash
terraform apply
```
This command will:
- Create the VPC, Subnet, Security Group, and Internet Gateway.
- Launch the EC2 instance.
- Set up the CloudWatch Alarm and SNS notifications.

### 4. Verify Resources
- **EC2 Instance**: Verify that the EC2 instance is running.
- **Security Group**: Ensure SSH (port 22) and HTTP (port 80) access is allowed.
- **CloudWatch Alarm**: Check the alarm under CloudWatch.
- **SNS Email**: Confirm the subscription email in your Gmail inbox.

### 5. Modify and Test Lifecycle Rules
The EC2 instance in `ec2.tf` includes the `create_before_destroy` rule:
```hcl
lifecycle {
  create_before_destroy = true
}
```
- Modify the instance type in `variables.tf`.
- Run `terraform apply` and observe that Terraform creates a new instance **before** deleting the old one.

---

## Outputs
After successful deployment, Terraform will display the following outputs:

- **EC2 Public IP**:
  ```bash
  The public IP address of the EC2 instance
  ```
- **VPC ID**
- **Subnet ID**
- **SNS Topic ARN**

These outputs are defined in `outputs.tf`.

---

## Clean Up
To delete all resources and clean up, run:
```bash
terraform destroy
```
Ensure that the S3 bucket and DynamoDB table are preserved as they store the Terraform state.

---

## Important Screenshots to Include
1. **S3 Bucket**:
   - Verify the Terraform state file in the S3 bucket.
![Screenshot from 2024-12-11 01-54-45](https://github.com/user-attachments/assets/14b4fb70-a855-4e5a-b3ca-3bc75f226a37)

2. **EC2 Instance**:
   - Screenshot of the EC2 instance running in the AWS Consol
![Screenshot from 2024-12-11 01-57-57](https://github.com/user-attachments/assets/d8e4ec7c-0824-466d-a8da-9010e1eadcb3)

3. **CloudWatch Alarm**:
   - Screenshot showing the high CPU alarm under CloudWatch.
![Screenshot from 2024-12-11 02-00-24](https://github.com/user-attachments/assets/b6c07e8b-2c31-4294-a55c-d864b91eae38)

4. **SNS Email Notification**:
   - Screenshot of the email notification received in Gmail.
![image](https://github.com/user-attachments/assets/76a5d269-73b3-4ef2-aeb5-e090c632a01e)

5. **Terraform Apply Output**:
   - Screenshot of the Terraform apply output in the terminal.
![image](https://github.com/user-attachments/assets/3df134d6-247e-444a-9e54-95d5acc3318e)

6. **Security Group Rules**:
   - Screenshot showing inbound rules for SSH (22) and HTTP (80).
![Screenshot from 2024-12-11 01-58-43](https://github.com/user-attachments/assets/233b5459-938d-4ceb-8cbd-69cae9570d03)
![Screenshot from 2024-12-11 02-16-24](https://github.com/user-attachments/assets/a1051c31-66e3-4136-a599-43a7a6dd7c11)



---

## Notes
- Always use **IAM roles** with least privilege when deploying AWS resources.
- Enable version control (e.g., Git) to track changes in Terraform configurations.
- Test lifecycle rules to understand their behavior (e.g., `create_before_destroy`, `prevent_destroy`).

---

## References
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS CloudWatch Alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
- [AWS SNS Notifications](https://docs.aws.amazon.com/sns/latest/dg/sns-getting-started.html)
