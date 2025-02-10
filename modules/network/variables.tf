variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnets"
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "igw" {
  description = "The internet gateway name"
  type        = string
}

variable "public_rt" {
  description = "The public route table name"
  type        = string
}

variable "private_rt" {
  description = "The private route table name"
  type        = string
}

variable "public_cidr_rt" {
  description = "The CIDR block for the public route table"
  type        = string
}

variable "private_cidr_rt" {
  description = "The CIDR block for the private route table"
  type        = string
}
