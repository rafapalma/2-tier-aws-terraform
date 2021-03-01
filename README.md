# Two-tier Architecture with Terraform

This project is a deployment of a two-tier architecture on Amazon Web Services (AWS) using Terraform and Packer.  

The architecture is composed by 3 instances:  
- Bastion Host  
- Web Server  
- Application Server  

The Bastion Host will be sitted in the public subnet with SSH access allowed from specific IPs, which can be set in the Terraform setup.

The Web server will be sitted in the public subnet with HTTP/HTTPS access allowed from the Internet. Only SSH connections from the Bastion Host is allowed.

The App server will be sitted in the private subnet with HTTP access allowed from the Web server. Only SSH connections from the Bastion Host is allowed.

The servers don't have connection to the Internet.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for testing purposes.


### Requirements

For this deployment is required the following to run:  
- Terraform  
- Packer  
- jq  

## Usage

### Installing Terraform:

On Ubuntu/Debian:

Add the HashiCorp GPG key:  
> `curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`

Add the official HashiCorp Linux repository:
> `sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`

Update and Install:
> `sudo apt-get update && sudo apt-get install terraform`

### Installing Packer

On Ubuntu/Debian:

> `sudo apt-get install packer`

### Installing jq

On Ubuntu/Debian:

> `sudo apt-get install jq`

### Setting-up your deployment

1. Add your aws-access-key and your aws-secret-key in the file ***terraform.tfvars***

2. In the ***packer*** folder, add your aws-access-key and your aws-secret-key in the file ***packer_ami.pkr.hcl***

3. Add the filename of your public key in the file ***keypairs.tf***

4. Copy your private and public key files in the folder ***keys***

5. Customize your deployment editing the variables in the file ***vars.tf***, changing parameters like:
   - AMI map  
   - Service Ports  
   - White-list of IPs/Ports to access the Bastion Host  
   - Prefix for your deployment environment

  
## Deployment

To deploy the infrastructure, run the command in the root folder:

> `sh build_launch.sh`

This will start the creation of a custom AMI using Packer. The default configuration uses an Amazon Linux image, installing Apache with SSL. This image will be used to launch the Web and App servers.

The AMI-ID for the custom AMI will be stored in the file ***ami_vars.tf***.

For the Bastion Host it is being used an Ubuntu image (see the *vars.tf* file).

Once the custom AMI is created, it will start the deployment on your AWS account using Terraform.

Terraform will show you the plan and all the resources that will be deployed in your account.

Type *yes* when you see the output below:

> ```
> Do you want to perform these actions?
>   Terraform will perform the actions described above.
>   Only 'yes' will be accepted to approve.
> 
>   Enter a value:
> ```

When Terraform is done with the deployment, it will output in the CLI the DNS-Names and IPs of the instances.

To test the deployment, you can access the public DNS name of the Web instance and add at the end of the URL ***/terraform/hello.html***.


## Contributing

To contribute to this deployment, clone this repo and commit your code in a separate branch.
