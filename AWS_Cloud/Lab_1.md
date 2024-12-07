# AWS Account Setup and IAM Configuration

This README provides instructions for setting up an AWS account, configuring IAM groups and users, setting billing alarms using **AWS Budgets**, and testing permissions with different IAM users.

## Prerequisites
- An AWS account.
- AWS CLI installed and configured (optional for some tasks).
- Administrative privileges on the AWS account.

---



## 1. **Create AWS Account**
1. Go to the [AWS Signup Page](https://portal.aws.amazon.com/billing/signup).
2. Follow the on-screen instructions to create an account.

---

## 2. **Set Billing Alarm Using AWS Budgets**
To avoid exceeding your budget, we'll use **AWS Budgets** to set a billing alarm.

1. Navigate to the **AWS Budgets** service:
   - In the **AWS Management Console**, type **"Budgets"** in the search bar and select **AWS Budgets**.
   
2. Create a new budget:
   - Click on **Create budget**.
   - Select **Cost budget** to monitor your spending.
   - Choose the budget type (**Fixed** or **Cost forecast**) and set your budgeted amount (e.g., `$1` per month).

3. Configure the alert:
   - Set the **Alert threshold** to a percentage (e.g., 80%).
   - Enter your **email address** or use **SNS** to get notified when the threshold is breached.

4. Review and create your budget to set up the alarm.

![Set Billing Alarm](screenshots/set_billing_alarm.png)

---

## 3. **Create IAM Groups**
1. Navigate to **IAM Console** > **User Groups** > **Create Group**.
2. **Admin Group**:
   - Name: `admin`
   - Attach the **AdministratorAccess** policy.
3. **Developer Group**:
   - Name: `developer`
   - Attach the **AmazonEC2FullAccess** policy.

![Screenshot from 2024-12-06 22-46-27](https://github.com/user-attachments/assets/1212fb01-c68b-47bb-8e28-46b3e7b7bb20)


---

## 4. **Create IAM Users**
### **Create `admin-1` User (Console Access Only)**
1. Go to **IAM Console** > **Users** > **Add User**.
2. Name: `admin-1`.
3. Enable **AWS Management Console Access** and set a password.
4. Add `admin-1` to the **admin** group.
5. Enable **MFA** for `admin-1`:
   - Use a virtual MFA app (e.g., Google Authenticator).
   - Scan the QR code and enter the two MFA codes to confirm.
 ![Screenshot from 2024-12-06 22-48-36](https://github.com/user-attachments/assets/d48e2206-4640-4b4e-96f9-be6b66a9088a)
 ![Screenshot from 2024-12-06 22-50-20](https://github.com/user-attachments/assets/53800a18-ec4d-4088-9871-9c0263c7e398)
![Screenshot from 2024-12-06 22-51-33](https://github.com/user-attachments/assets/19554986-4e9a-4455-bfde-b8f384fea01a)
![Screenshot from 2024-12-06 23-11-03](https://github.com/user-attachments/assets/513a3cc2-3ac0-4114-bdd6-f2d4dfde8b60)
![Screenshot from 2024-12-06 23-18-48](https://github.com/user-attachments/assets/8e1bfd36-df9a-41fc-953f-75f0081f9d30)





    

![Create Admin-1 User](screenshots/create_admin_1_user.png)

### **Create `admin-2-prog` User (CLI Access Only)**
1. Go to **IAM Console** > **Users** > **Add User**.
2. Name: `admin-2-prog`.
3. Enable **Programmatic Access** (for CLI).
4. Add `admin-2-prog` to the **admin** group.
5. Download the **Access Key ID** and **Secret Access Key** for future use.
![Screenshot from 2024-12-06 23-27-43](https://github.com/user-attachments/assets/e6519740-4ad9-4ae8-9b01-3d1a6b718de5)
![Screenshot from 2024-12-06 23-32-15](https://github.com/user-attachments/assets/6f580034-4c7c-416a-b065-a4bbca805264)
![Screenshot from 2024-12-06 23-33-08](https://github.com/user-attachments/assets/dba7ab96-e714-459a-82b6-ecd826e4f93c)




   

### **Create `dev-user` (Programmatic and Console Access)**
1. Go to **IAM Console** > **Users** > **Add User**.
2. Name: `dev-user`.
3. Enable both **AWS Management Console Access** and **Programmatic Access**.
4. Add `dev-user` to the **developer** group.
5. Set a password for console access and download the programmatic credentials.

![Screenshot from 2024-12-06 23-37-46](https://github.com/user-attachments/assets/df707400-88e5-454f-b862-2f4a20c69e7f)



---

## 5. **List IAM Users and Groups Using AWS CLI**
1. **Configure AWS CLI** with the `admin-2-prog` user's credentials:
   ```bash
   aws configure
   ```
 ## Note: login with access key and secreate access key to `admin-2-prog`
 
## 6. list users with admin-2-prog
 ```bash
   aws iam list-users

   ```
![Screenshot from 2024-12-07 00-44-41](https://github.com/user-attachments/assets/33781680-2be9-4cef-a9dc-213d3e2ed515)

## 7. Verify Permissions for dev-user
1. Log in to the AWS Console as dev-user:
* Use the AWS Management Console credentials.
* Verify that dev-user can access EC2.
* Try accessing S3 (permission should be denied).

2. Test CLI Access as dev-user:
* Configure the AWS CLI with dev-user's credentials:
   ```bash
   aws configure
   ```
   ## * Note to login to dev-user

  * Test EC2 Access:
   ```bash
   aws ec2 describe-instances
   ```
  ![Screenshot from 2024-12-07 00-40-11](https://github.com/user-attachments/assets/3d3002f1-4b70-4a48-89ce-76d3ffd1d156)

* Test S3 Access (should fail):
   ```bash
   aws s3 ls
   ```
   ![Screenshot from 2024-12-07 00-39-33](https://github.com/user-attachments/assets/c9a5c909-727f-40ee-a5c5-b1cbc661e1a5)
  
## 3. Test access management console  Access as dev-user:
![Screenshot from 2024-12-07 00-53-23](https://github.com/user-attachments/assets/c7affbc5-b735-46c9-8bb7-0994bb3c144e)

* NOTE Deny to access S3 by console :
  
![Screenshot from 2024-12-07 00-55-35](https://github.com/user-attachments/assets/28325de9-2750-4d72-9cd2-2e326b447ab2)


# Summary of Tasks

* ### AWS Account: Created.
* ### Billing Alarm: Set up using AWS Budgets to notify when spending exceeds a defined threshold.
* ### IAM Groups: admin with full permissions, developer with EC2-only access.
* ### IAM Users:
   * admin-1: Console access with MFA enabled.
   *admin-2-prog: CLI access with programmatic credentials.
   * dev-user: Console and programmatic access with limited permissions.
* ### Permissions Test: Verified access to EC2 and S3 for dev-user.    

 




  

