
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["test"] 
  }
}

resource "aws_instance" "name" {
    ami= "ami-" 
    key_name = "manaswini"
    instance_type ="t2.nano"
    tags = {
      Name="manu"
    }
} 