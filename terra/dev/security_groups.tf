resource "aws_security_group" "private_subnet" {
  name        = "private"
  description = "Allow TLS and SSH inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.private_subnet.id
  cidr_ipv4         = var.cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_self" {
  security_group_id = aws_security_group.private_subnet.id
  referenced_security_group_id = aws_security_group.private_subnet.id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.private_subnet.id
  cidr_ipv4         = var.cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_self" {
  security_group_id = aws_security_group.private_subnet.id
  referenced_security_group_id = aws_security_group.private_subnet.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}