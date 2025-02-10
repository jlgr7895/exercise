resource "aws_security_group" "bastion_sg" {
  name        = "allow_bastion_traffic"
  description = "Allow Bastion traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_bastion_traffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_web_ipv4" {
  for_each = { for idx, rule in var.bastion_ingress_rules : idx => rule }

  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = each.value.cidr_block
  from_port         = each.value.from_port
  ip_protocol       = each.value.protocol
  to_port           = each.value.to_port
}

resource "aws_security_group" "ssh_sg" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id            = aws_security_group.ssh_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port                    = var.ssh_ingress_rule.from_port
  ip_protocol                  = var.ssh_ingress_rule.protocol
  to_port                      = var.ssh_ingress_rule.to_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_bastion" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ssh" {
  security_group_id = aws_security_group.ssh_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
