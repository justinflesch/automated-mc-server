# Automated Minecraft Server Tutorial

## Background

The purpose of the files in this repository are to automate the set up of a Minecraft server.  The files do this using terraform to set up an EC2 and security group in AWS, then using a bash script on the EC2 to deploy a Minecraft server from scratch.  The bash script edits the crontab of the EC2 so the Minecraft server starts each time the EC2 does.

## Requirements

These are the necessary tools that need to be downloaded and set up on your local machine to move forward with setup:

* [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

Set up a public key and private key pair with AWS so that when it's time to connect to the machine, it can be done easily.  Make sure to set your own key to the key name in the main.tf file of this repository.

## Steps

Here is a detailed list of steps to automate the creation of this server:

* Download and unzip the files from this repository, cd into the directory
* Change the key in main.tf to the key you made
* If you have terraform all set up, just run `terraform apply` (this will create the EC2 instance and security group with proper settings)
* Save the public IPv4 from the creation output for later
* Use that (and your key) to edit the deploy_playbook.yml ansible playbook file (where x-x-x-x is the IPv4 address)
* Open the deploy_minecraft.sh file on your local machine, edit the server name and make the bedrock version the newest one (when you run this script is executed by the ansible playbook, it will install all necessary packages for the Minecraft server, add the server to the crontab so it runs on startup, then attempt to run it)
* Run the ansible playbook with `ansible-playbook deploy_playbook.yml`
* At this point you should be able to connect with the following settings:
  * Name: Example name
  * IP: IP saved from earlier
  * Port: 19132