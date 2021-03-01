resource "aws_instance" "bastion_host" {
    ami = lookup(var.AMIS, var.aws_region)
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [ aws_security_group.secgroup-bastionhost.id ]
    key_name = aws_key_pair.keypair.key_name
    tags = {
        "Name" = "Bastion Host"
    }
}

resource "aws_instance" "web_server" {
    ami = var.AMI_ID
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [ aws_security_group.secgroup-webserver.id ]
    key_name = aws_key_pair.keypair.key_name
    tags = {
        "Name" = "Web Server"
    }
}

resource "aws_instance" "app_server" {
    ami = var.AMI_ID
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private-subnet.id
    vpc_security_group_ids = [ aws_security_group.secgroup-appserver.id ]
    key_name = aws_key_pair.keypair.key_name
    tags = {
        "Name" = "App Server"
    }
}
