resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "private_subnet" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.public_rt
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = var.public_cidr_rt
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table" "private_rt" {
  count  = length(values(aws_subnet.private_subnet))
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.private_rt}-${count.index}"
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = values(aws_subnet.private_subnet)[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}

resource "aws_eip" "nat_eip" {
  count  = length(values(aws_subnet.private_subnet))
  domain = "vpc"
  tags = {
    Name = "eip NAT - ${count.index}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(values(aws_subnet.public_subnet))
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = values(aws_subnet.public_subnet)[count.index].id
  tags = {
    Name = "gw NAT - ${count.index}"
  }
}

resource "aws_route" "private_internet_access" {
  count                  = length(values(aws_subnet.private_subnet))
  route_table_id         = aws_route_table.private_rt[count.index].id
  destination_cidr_block = var.private_cidr_rt
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}
