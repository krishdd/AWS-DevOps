## How to install and configure Ansible on RHEL

- The easiest way to install Ansible is by adding a third-party repository named EPEL (Extra Packages for Enterprise Linux), which is maintained over at http://fedoraproject.org/wiki/EPEL. You can easily add the repo by running the following command:
```sh
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```
- No other software is required as Ansible utilizes SSH to interact with remote servers, however, if you want to execute without providing password, ssh keys must be confgiured.
#### Installing Ansible
```sh
yum update
yum -y install ansible
```
Once the above has completed, you can confirm that Ansible is installed 
```sh
ansible --version
```
#### Config files:
- Before we create a basic configuration, I want to take a moment to explain the Ansible file/folder structure. You’ll note that if you list the files/folders in /etc/ansible that you’re presented with the following. Alongside, I have included an explanation for each file or folder.

1. /etc/ansible — The main configuration folder which encompasses all Ansible config
1. /etc/ansible/hosts — This file holds information for the hosts/and host groups you will configure
1. /etc/ansible/ansible.cfg — The main configuration file for Ansible
1. /etc/ansible/roles — This folder allows you to create folders for each server role, web/app/db, etc.
- It is advisable to use a proper role structure in Ansible, as this makes it easier to manage your playbooks.


1. Tasks — This can be used to include smaller files or provide further instructions.
1. Handlers — This can be used to do things like restart a service or carry out other tasks.
1. Templates — You can vary certain things in this to produce dynamic configuration files.
1. Files — This one is simple. It’s a static file which probably doesn’t need to be different across servers.


##### Create a basic configuration

To execute command on remote host:
```sh
ansible <host> -m command -a “command_to_run”.
ansible ip-10-20-30-142 -m command -a "uname -r"
```
##### Run simple play book to install httpd
```sh
ansible-playbook <playbook-name>.yml

- hosts: ip-10-20-30-142
  tasks:
    - name: install
      yum: name=httpd update_cache=yes state=latest
```
##### To remove packages
```sh 
- hosts: ip-10-20-30-142
  tasks:
    - name: install
      yum: name=httpd update_cache=yes state=absent
      ```

