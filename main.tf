terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.86.0"
    }
  }

  required_version = ">= 1.10.0"
}

provider "aws" {
  profile = "me"
  region  = "us-west-1"
  default_tags {
    tags = {
      env    = "test"
      IAC    = "Terraform"
      author = "Luis"
    }
  }
}

module "network" {
  source          = "./modules/network"
  vpc_cidr_block  = var.vpc_main_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  igw             = var.igw
  public_rt       = var.public_rt
  private_rt      = var.private_rt
  public_cidr_rt  = var.default_cidr_block
  private_cidr_rt = var.default_cidr_block
}

module "security" {
  source             = "./modules/security"
  vpc_id             = module.network.vpc_id
  default_cidr_block = var.default_cidr_block
}

module "compute" {
  source             = "./modules/compute"
  public_subnet_ids  = module.network.public_subnet_ids
  bastion_sg         = module.security.bastion_sg
  private_subnet_ids = module.network.private_subnet_ids
  ssh_sg             = module.security.ssh_sg
}

# module "tfstate-backend" {
#   source     = "cloudposse/tfstate-backend/aws"
#   version    = "1.5.0"
#   namespace  = "eg-luis"
#   stage      = "test"
#   name       = "terraform"
#   attributes = ["state"]

#   terraform_backend_config_file_path = "."
#   terraform_backend_config_file_name = "backend.tf"
#   force_destroy                      = false
# }
