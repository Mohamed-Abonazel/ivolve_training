# AWS Account Setup and IAM Configuration

This README provides instructions for setting up an AWS account, configuring IAM groups and users, setting billing alarms, and testing permissions with different IAM users.

## Prerequisites
- An AWS account.
- AWS CLI installed and configured (optional for some tasks).
- Administrative privileges on the AWS account.

---

## 1. **Create AWS Account**
1. Go to the [AWS Signup Page](https://portal.aws.amazon.com/billing/signup).
2. Follow the on-screen instructions to create an account.

---

## 2. **Set Billing Alarm**
1. Navigate to **CloudWatch** in the AWS Management Console.
2. Select **Alarms** > **Create Alarm**.
3. Under **Select metric**, choose **Billing** and select **Total Estimated Charges**.
4. Set a threshold (e.g., `$10`) and create an alarm.
5. Configure **SNS notifications** to be alerted when the threshold is exceeded.

---

## 3. **Create IAM Groups**
1. Navigate to **IAM Console** > **User Groups** > **Create Group**.
2. **Admin Group**:
   - Name: `admin`
   - Attach the **AdministratorAccess** policy.
3. **Developer Group**:
   - Name: `developer`
   - Attach the **AmazonEC2FullAccess** policy.

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

---

## 5. **List IAM Users and Groups Using AWS CLI**
1. **Configure AWS CLI** with the `admin-2-prog` user's credentials:
   ```bash
   aws configure

