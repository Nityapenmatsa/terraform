terraform {
  backend "s3" {
    bucket = "manuvarma17"
    region = "us-east-1"
    key = "terraform.tfstate"
    dynamodb_table = "terraform_state_lock_dynamo"
    encrypt = true
    
  }
}