terraform {
  backend "s3" {
    bucket = "keithvueportfoliowebsite"
    key    = "dev/terraform.tfstate"
    region = "ap-southeast-1"
  }
}