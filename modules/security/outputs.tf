output "bastion_sg" {
  description = "value of the security group ID"
  value       = aws_security_group.bastion_sg.id

}

output "ssh_sg" {
  description = "value of the security group ID"
  value       = aws_security_group.ssh_sg.id
}
