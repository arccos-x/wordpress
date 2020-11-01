variable "aws_default_region" {
    description = "default AWS region"
}

variable "aws_profile" {
    description = "AWS profile name as set in the shared credentials file"
}

variable "prefix" {
    description = "Prefix for all the resources to be created"
    default = "wordpress" 
}

variable "site_domain" {
  description = "The primary domain name of the website"
}

variable "db_master_username" {}

variable "db_master_password" {}

