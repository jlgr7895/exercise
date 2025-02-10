terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    region  = "us-west-1"
    bucket  = "eg-luis-test-terraform-state"
    key     = "terraform.tfstate"
    profile = "me"
    encrypt = "true"

    dynamodb_table = "eg-luis-test-terraform-state-lock"
  }
}
