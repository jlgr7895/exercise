vpc_main_cidr = "10.0.0.0/16"

public_subnets = {
  subnet_a = {
    name              = "public_subnet_a"
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-west-1a"
  }
  subnet_b = {
    name              = "public_subnet_b"
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-west-1b"
  }
}

private_subnets = {
  subnet_a = {
    name              = "private_subnet_a"
    cidr_block        = "10.0.16.0/20"
    availability_zone = "us-west-1a"
  }
  subnet_b = {
    name              = "prjvate_subnet_b"
    cidr_block        = "10.0.32.0/20"
    availability_zone = "us-west-1b"
  }
}

igw        = "igw-main"
public_rt  = "public-rt-main"
private_rt = "private-rt-main"