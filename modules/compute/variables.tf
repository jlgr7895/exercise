variable "public_subnet_ids" {
  description = "value of the public subnet IDs"
  type        = list(string)
}

variable "bastion_sg" {
  description = "value of the security group ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "value of the private subnet IDs"
  type        = list(string)
}

variable "ssh_sg" {
  description = "value of the security group ID"
  type        = string
}
