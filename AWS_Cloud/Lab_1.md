# AWS Account Setup and IAM Configuration

This README provides instructions for setting up an AWS account, configuring IAM groups and users, setting billing alarms using **AWS Budgets**, and testing permissions with different IAM users.

## Prerequisites
- An AWS account.
- AWS CLI installed and configured (optional for some tasks).
- Administrative privileges on the AWS account.

---![Screenshot from 2024-12-07 01-56-48](https://github.com/user-attachments/assets/06414a41-4e4c-470b-93ad-42d4da178f18)


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

![Create IAM Group](screenshots/create_iam_group.png)

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

![Create Admin-1 User](screenshots/create_admin_1_user.png)

### **Create `admin-2-prog` User (CLI Access Only)**
1. Go to **IAM Console** > **Users** > **Add User**.
2. Name: `admin-2-prog`.
3. Enable **Programmatic Access** (for CLI).
4. Add `admin-2-prog` to the **admin** group.
5. Download the **Access Key ID** and **Secret Access Key** for future use.

### **Create `dev-user` (Programmatic and Console Access)**
1. Go to **IAM Console** > **Users** > **Add User**.
2. Name: `dev-user`.
3. Enable both **AWS Management Console Access** and **Programmatic Access**.
4. Add `dev-user` to the **developer** group.
5. Set a password for console access and download the programmatic credentials.

![Create Dev-User](screenshots/create_dev_user.png)

---

## 5. **List IAM Users and Groups Using AWS CLI**
1. **Configure AWS CLI** with the `admin-2-prog` user's credentials:
   ```bash
   aws configure
