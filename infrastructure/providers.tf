provider "aws" {
  region        = var.aws_default_region
  profile       = var.aws_profile
}

provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = var.aws_profile
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "random" {
  version = "~> 2.2"
}

