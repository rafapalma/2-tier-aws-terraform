# Create Security Groups
resource "aws_security_group" "secgroup-bastionhost" {
    vpc_id = aws_vpc.vpc.id
    name = "secgroup-bastionhost"
    description = "Jump Host Security Group"
}

resource "aws_security_group" "secgroup-webserver" {
    vpc_id = aws_vpc.vpc.id
    name = "secgroup-webserver"
    description = "Web Server Security Group"
}

resource "aws_security_group" "secgroup-appserver" {
    vpc_id = aws_vpc.vpc.id
    name = "secgroup-appserver"
    description = "App Server Security Group"
}

# Create Security Group Ingress Rule for Jump Host
resource "aws_security_group_rule" "bastionhost_ingress_admin" {
    for_each = var.allow_list
    type = "ingress"
    protocol = "tcp"
    cidr_blocks = each.value[1]
    from_port = each.value[0]
    to_port = each.value[0]
    security_group_id = aws_security_group.secgroup-bastionhost.id
}

# Create Security Group Ingress Rules for Web Server
resource "aws_security_group_rule" "webserver_ingress_http" {
    count = length(var.web_ports_ssl)
    type = "ingress"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = element(var.web_ports_ssl, count.index)
    to_port = element(var.web_ports_ssl, count.index)
    security_group_id = aws_security_group.secgroup-webserver.id
}

resource "aws_security_group_rule" "webserver_ingress_admin" {
    count = length(var.admin_ports)
    type = "ingress"
    protocol = "tcp"
    source_security_group_id = aws_security_group.secgroup-bastionhost.id
    from_port = element(var.admin_ports, count.index)
    to_port = element(var.admin_ports, count.index)
    security_group_id = aws_security_group.secgroup-webserver.id
}

# Create Security Group Ingress Rules for App Server
resource "aws_security_group_rule" "appserver_ingress_http" {
    count = length(var.web_ports)
    type = "ingress"
    protocol = "tcp"
    source_security_group_id = aws_security_group.secgroup-webserver.id
    from_port = element(var.web_ports, count.index)
    to_port = element(var.web_ports, count.index)
    security_group_id = aws_security_group.secgroup-appserver.id
}

resource "aws_security_group_rule" "appserver_ingress_admin" {
    count = length(var.admin_ports)
    type = "ingress"
    protocol = "tcp"
    source_security_group_id = aws_security_group.secgroup-bastionhost.id
    from_port = element(var.admin_ports, count.index)
    to_port = element(var.admin_ports, count.index)
    security_group_id = aws_security_group.secgroup-appserver.id
}

# Create Security Group Egress Rules for Jump Host
resource "aws_security_group_rule" "bastionhost_egress_admin_public" {
    count = length(var.admin_ports)
    type = "egress"
    protocol = "tcp"
    cidr_blocks = [aws_subnet.public-subnet.cidr_block]
    from_port = element(var.admin_ports, count.index)
    to_port = element(var.admin_ports, count.index)
    security_group_id = aws_security_group.secgroup-bastionhost.id
}

resource "aws_security_group_rule" "bastionhost_egress_admin_private" {
    count = length(var.admin_ports)
    type = "egress"
    protocol = "tcp"
    cidr_blocks = [aws_subnet.private-subnet.cidr_block]
    from_port = element(var.admin_ports, count.index)
    to_port = element(var.admin_ports, count.index)
    security_group_id = aws_security_group.secgroup-bastionhost.id
}

#Create Security Group Egress Rules for Web Server
resource "aws_security_group_rule" "webserver_egress_default" {
    count = length(var.web_ports)
    type = "egress"
    protocol = "tcp"
    cidr_blocks = [aws_subnet.private-subnet.cidr_block]
    from_port = element(var.web_ports, count.index)
    to_port = element(var.web_ports, count.index)
    security_group_id = aws_security_group.secgroup-webserver.id
}
