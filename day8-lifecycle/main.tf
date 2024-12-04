resource "aws_instance" "name" {
    ami = "ami-0453ec754f44f9a4a"
    instance_type = "t2.micro"
    availability_zone = "us-east-1c"
    tags = {
      Name="nitya"
    }
    #lifecycle {
     # create_before_destroy = true
    #}
    #lifecycle {
     # prevent_destroy = true
    #}
    lifecycle {
      ignore_changes = [ tags, ]
    }
  
}
