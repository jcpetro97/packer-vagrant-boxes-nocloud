
variable "version" {
  type    = string
  default = ""
}

source "virtualbox-iso" "autogenerated_1" {
  boot_command            = ["<enter><enter><f6><esc><wait>", "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<wait><enter>"]
  boot_wait               = "5s"
  disk_size               = 51200
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  headless                = true
  http_directory          = "http"
  iso_checksum            = "sha256:f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
  iso_urls                = ["ubuntu-20.04.3-live-server-amd64.iso", "http://releases.ubuntu.com/focal/ubuntu-20.04.3-live-server-amd64.iso"]
  shutdown_command        = "echo 'vagrant'|sudo -S shutdown -P now"
  ssh_handshake_attempts  = "200"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_username            = "vagrant"
  ssh_wait_timeout        = "10000s"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "2048"], ["modifyvm", "{{ .Name }}", "--cpus", "1"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer-ubuntu-20.04-amd64"
  vrdp_bind_address       = "0.0.0.0"
}

build {
  sources = ["source.virtualbox-iso.autogenerated_1"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/ansible.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/setup.sh"
  }

  provisioner "ansible-local" {
    galaxy_file   = "../shared/requirements.yml"
    playbook_file = "../shared/main.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/cleanup.sh"
  }

  post-processor "vagrant" {
    output = "builds/<no value>-ubuntu2004.box"
  }
}
