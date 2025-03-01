terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

  default_tags {
    tags = {
      Managed_by    = "Terraform"
      Environment   = "dev"
      Project-Topic = "Deploy vuejs app to s3 and cloudfront"
    }
  }
}
