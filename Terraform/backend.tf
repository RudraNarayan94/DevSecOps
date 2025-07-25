terraform {
  backend "s3" {
    bucket = "currency-converter-terraform-state-rudra-9483ac"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
