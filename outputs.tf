# DNS and IPs information for Bastion Host
output "bastion-host-public-dns" {
    value = aws_instance.bastion_host.public_dns
}

output "bastion-host-public-ip" {
    value = aws_instance.bastion_host.public_ip
}

output "bastion-host-private-ip" {
    value = aws_instance.bastion_host.private_ip
}

# DNS and IPs information for Web Server
output "webserver-public-dns" {
    value = aws_instance.web_server.public_dns
}

output "webserver-public-ip" {
    value = aws_instance.web_server.public_ip
}

output "webserver-private-ip" {
    value = aws_instance.web_server.private_ip
}

# DNS and IPs information for App Server
output "appserver-private-dns" {
    value = aws_instance.app_server.private_dns
}

output "appserver-private-ip" {
    value = aws_instance.app_server.private_ip
}