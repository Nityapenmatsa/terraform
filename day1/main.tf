resource "aws_instance" "name" {
    ami="ami-0453ec754f44f9a4a"
    key_name = "manaswi"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"

  
}