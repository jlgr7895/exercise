variable "vpc_main_cidr" {
  description = "The CIDR block for the VPC main"
  type        = string
}

variable "public_subnets" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
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

variable "default_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "0.0.0.0/0"
}

variable "access_key" {
  description = "The access key for the AWS account"
  type        = string
}

variable "secret_key" {
  description = "The secret key for the AWS account"
  type        = string
}
