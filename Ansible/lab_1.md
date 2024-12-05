# Lab 7: Install and configure Ansible Automation Platform on control nodes, create inventories of a managed host, and then perform ad-hoc commands to check functionality.

## 1. install ansible on ubuntu 
```bash
sudo apt-get update
sudo apt-get upgrade -y 

```
## 2. Install required dependencies:
```bash
sudo apt-get install -y software-properties-common

```
## 3. Add Ansible repository and refresh package list:
```bash
sudo apt-add-repository --yes --update ppa:ansible/ansible

```
## 4. Install Ansible:
```bash
sudo apt-get install -y ansible

#Verify the installation:
ansible --version

```
# Test Ansible ad-hoc commands
## 1. Create ansible.cfg
```bash
vim ansible.cfg

```
add the following:

```bash
[defaults]
inventory = ./inventory
host_key_checking = False
remote_user = ec2-user
private_key_file = ./amazon.pem

```
## 2. Create inventory
```bash
vim inventory

```

add the following:
```bash
[webservers]
ec2-54-161-238-251.compute-1.amazonaws.com

```
## 3. Run some ad-hoc commands
* Note:
Using with sudo (become):

```bash
# Add -b or --become to use sudo
ansible webservers -b -m shell -a "tail /var/log/messages"

```

## 1. Basic ping test:

```bash
# Test ping
ansible webservers -m ping

```
## 2. Check system uptime and load:
```bash
ansible webservers -m shell -a "uptime"

```











