#!/bin/bash -eux

## if for some reason the EPEL method no longer works, then remove that line, and
## uncomment the python lines below 

# Install Python.
# yum -y install python3 python3-pip
# alternatives --set python /usr/bin/python3
# python -m pip install -U pip
# # Install Ansible.
# python -m pip install ansible==2.9.17

# Install EPEL.
yum -y install epel-release git

# Install Ansible.
yum -y install ansible
