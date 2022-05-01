### John Petro's Vagrant Box Builds


This project contains the Packer build configurations for all of John Petro's Vagrant Boxes. Each box builds a minimal base box for use with VirtualBox. Available boxes include:

  - [jcpetro97/centos7](https://app.vagrantup.com/jcpetro97/boxes/centos7) - [`centos7` directory](centos7/)
  - [jcpetro97/debian10](https://app.vagrantup.com/jcpetro97/boxes/debian10) - [`debian10` directory](debian10/)
  - [jcpetro97/debian11](https://app.vagrantup.com/jcpetro97/boxes/debian11) - [`debian11` directory](debian11/)
  - [jcpetro97/rocky8](https://app.vagrantup.com/jcpetro97/boxes/rocky8) - [`rocky8` directory](rocky8/)
  - [jcpetro97/ubuntu2004](https://app.vagrantup.com/jcpetro97/boxes/ubuntu2004) - [`ubuntu2004` directory](ubuntu2004/)  
  - [jcpetro97/ubuntu2204](https://app.vagrantup.com/jcpetro97/boxes/ubuntu2204) - [`ubuntu2204` directory](ubuntu2204/)

All of these boxes are available as public, free Vagrant boxes and can be used with the command:

    vagrant init jcpetro97/[box name here]

If you want to see how to integrate one of these configs into building a vagrant box for development of a specific app, check out the following  [Drupal VM Packer Build](https://github.com/geerlingguy/packer-drupal-vm).

## Requirements

The following software must be installed/present on your local machine before you can use Packer to build any of these Vagrant boxes:

  - [Packer](http://www.packer.io/)
  - [Vagrant](http://vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/)
  - [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Usage

Make sure all the required software (listed above) is installed, then cd into one of the box directories and run:

    $ packer build -var 'version=1.2.0' box-config.json

After a few minutes, Packer should tell you the box was generated successfully, and the box was uploaded to Vagrant Cloud.

> **Note**: This configuration includes a post-processor that pushes the built box to Vagrant Cloud (which requires a `VAGRANT_CLOUD_TOKEN` environment variable to be set); remove the `vagrant-cloud` post-processor from the Packer template to build the box locally and not push it to Vagrant Cloud. You don't need to specify a `version` variable either, if not using the `vagrant-cloud` post-processor.

### Building _all_ the boxes

Whenever VirtualBox is updated, it's best to re-build _all_ the base boxes so they have the latest guest additions.

Assuming you have Ansible and Packer installed already, and you have a `VAGRANT_CLOUD_TOKEN` available in your environment, you can run the playbook to build and push updated versions for all the boxes:

    ansible-playbook build-boxes.yml

You can also build and push just one box:

    ansible-playbook build-boxes.yml -e "{'boxes':['debian10']}"

## Testing built boxes

There's an included Vagrantfile that allows quick testing of the built Vagrant boxes. From the same box directory, run the following command after building the box:

    $ vagrant up

Test that the box works correctly, then tear it down with:

    $ vagrant destroy -f

## License

MIT

## Author

These configs are maintained by [John Petro](https://github.com/jcpetro97).  

This repository was based off the the repository created by [Jeff Geerling](https://www.jeffgeerling.com), author of [Ansible for DevOps](https://www.ansiblefordevops.com).
