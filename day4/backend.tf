terraform {
  backend "s3" {
    bucket = "terraaformmmpractice"
    region = "us-east-1"
    key = "day4/terraform.tfstate"
    encrypt = true
    
  }
}