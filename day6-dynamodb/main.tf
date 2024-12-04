resource "aws_s3_bucket" "name" {
    bucket = "manuvarma17"
  
}
resource "aws_dynamodb_table" "dynamodb_terraform_state_lock" {
    name = "terraform_state_lack_dynamo"
    hash_key = "LockID"
    read_capacity = 20
    write_capacity = 20
    attribute {
      name = "LockID"
      type = "S"
    
    }

  
}