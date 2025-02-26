terraform {
  backend "s3" {
    bucket = "portfoliowebsiteconfig"
    key    = "dev/terraform.tfstate"
    region = "ap-southeast-1"
  }
}