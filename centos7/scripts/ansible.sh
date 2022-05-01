#!/bin/bash -eux

# Install EPEL.
yum -y install epel-release git

# Install Ansible.
yum -y install ansible
