variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "default_cidr_block" {
  description = "The default CIDR block"
  type        = string
}

variable "ssh_ingress_rule" {
  description = "SSH ingress rule"
  type = object({
    from_port = number
    to_port   = number
    protocol  = string
  })

  default = { from_port = 22, to_port = 22, protocol = "tcp" }
}

variable "bastion_ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port  = number
    to_port    = number
    protocol   = string
    cidr_block = string
  }))

  default = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_block = "0.0.0.0/0" },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_block = "0.0.0.0/0" },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_block = "0.0.0.0/0" }
  ]
}
