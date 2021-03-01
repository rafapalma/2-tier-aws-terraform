#!/bin/bash
packer build ./packer/packer_ami.pkr.hcl
AMI_ID=$(jq -r '.builds[-1].artifact_id' ./packer/manifest.json | awk -F: '{print $2}')
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" } ' > ami_vars.tf
terraform init
terraform apply
