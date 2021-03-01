variable "aws_access_key" {
    default = "<YOUR-ACCESS-KEY-HERE>"
}

variable "aws_secret_key" {
    default = "<YOUR-SECRET-KEY-HERE>"
}

variable "region" {
    type    = string
    default = "us-east-1"
}

variable "ami-slvpn" {
  type    = string
  default = "ami-047a51fa27710816e"
}

source "amazon-ebs" "amazon-ec2-slvpn-apache" {
    access_key    = var.aws_access_key
    secret_key    = var.aws_secret_key
    region        = var.region
    ami_name      = "amazon-ec2-slvpn-apache"
    instance_type = "t2.micro"
    ssh_username = "ec2-user"
    source_ami = var.ami-slvpn
}

build {
    sources = ["source.amazon-ebs.amazon-ec2-slvpn-apache"]

    provisioner "shell" {
        script = "./scripts/webserver.sh"
    }

    post-processor "manifest" {
        output = "./packer/manifest.json"
        strip_path = true
    }
}
