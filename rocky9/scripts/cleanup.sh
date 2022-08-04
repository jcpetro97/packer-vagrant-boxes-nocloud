#!/bin/bash -eux

# Remove Ansible and its dependencies.
##### If at some point the EPEL method of installing ansible doesn't work, just uncomment the lines below.
##### and then remove the yum remove section.

# python -m pip install pip-autoremove
# ln -s /usr/bin/pip3 /usr/bin/pip
# /usr/local/bin/pip-autoremove ansible -y
# rm -f /usr/bin/pip
# python -m pip uninstall pip-autoremove -y

# Remove Ansible and its dependencies.
dnf -y remove ansible

if [ -d /home/vagrant/.ansible ]; then
    echo "removing /home/vagrant/.ansible"
    sudo rm -rf /home/vagrant/.ansible
fi

sudo dnf clean all
