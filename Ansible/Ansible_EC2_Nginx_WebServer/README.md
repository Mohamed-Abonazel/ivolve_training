# Ansible EC2 Nginx WebServer Deployment

#  🚀 Overview
## This Ansible project automates the deployment and configuration of Nginx web servers on Amazon EC2 instances. It sets      up multiple web servers with custom HTML content and proper security configurations.

# 📋 Features

* Automated Apache installation and configuration
* Secure passwordless sudo setup
* Custom HTML deployment with dynamic hostname display
* Multi-server deployment support
* Automated service management

# Project Structure
### Ansible_EC2_Nginx_WebServer/ ├── webserver_setup.yml # Main playbook ├── ansible.cfg # Ansible configuration ├── inventory # Server inventory file └── ivolve-admin.pem # AWS EC2 key pair (not included in repo)

# Prerequisites

  * Ansible installed on control machine
  * Valid AWS EC2 instances
  * SSH access to EC2 instances
  * Python installed on target hosts
  * AWS EC2 key pair (.pem file)
    
# ⚙️ Configuration
## Inventory Setup




## Ansible Configuration(ansible.cfg) 
