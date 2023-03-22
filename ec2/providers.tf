terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "accesskey"
  secret_key = "secretkey"
}

