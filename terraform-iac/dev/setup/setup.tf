terraform {
  backend "s3" {
    bucket         = "terraform-state-storage-646364352403"
    dynamodb_table = "terraform-state-lock-646364352403"
    key            = "hello-world-api-dev/setup.tfstate"
    region         = "us-west-2"
  }
}

provider "aws" {
  version = "~> 2.42"
  region  = "us-west-2"
}

variable "some_secret" {
  type        = string
  description = "Some secret string that will be stored in SSM and mounted into the Fargate Tasks as an environment variable"
}

module "setup" {
  source      = "../../modules/setup/"
  env         = "dev"
  some_secret = var.some_secret
}
