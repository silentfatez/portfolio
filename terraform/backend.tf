terraform {
  backend "s3" {
    bucket = "keithportfoliowebsite"
    key    = "dev/terraform.tfstate"
    region = "ap-southeast-1"
  }
}