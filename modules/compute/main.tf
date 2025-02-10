resource "aws_instance" "bastion" {
  for_each               = { for idx, subnet in var.public_subnet_ids : idx => subnet }
  ami                    = "ami-03d49b144f3ee2dc4"
  instance_type          = "t2.micro"
  subnet_id              = each.value
  key_name               = data.aws_key_pair.my_key.key_name
  user_data              = file("${path.module}/user_data.sh")
  vpc_security_group_ids = [var.bastion_sg]
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.004
    }
  }


}

resource "aws_instance" "worker" {
  for_each               = { for idx, subnet in var.private_subnet_ids : idx => subnet }
  ami                    = "ami-03d49b144f3ee2dc4"
  instance_type          = "t2.micro"
  subnet_id              = each.value
  key_name               = data.aws_key_pair.my_key.key_name
  vpc_security_group_ids = [var.ssh_sg]
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.004
    }
  }
}

data "aws_key_pair" "my_key" {
  key_name = "mykey"
}
