resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="vpc"
    }
  
}
resource "aws_subnet" "dev" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name="subnet"
    }
  
}
resource "aws_internet_gateway" "dev" {
    vpc_id = aws_vpc.dev.id
    tags = {
      Name="ig"
    }
  
}
resource "aws_route_table" "dev" {
    vpc_id = aws_vpc.dev.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev.id
    }
  
}
resource "aws_route_table_association" "dev" {
    subnet_id = aws_subnet.dev.id
    route_table_id = aws_route_table.dev.id
  
}
resource "aws_security_group" "dev" {
    name = "dev"
    vpc_id = aws_vpc.dev.id
    tags = {
      Name="dev"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}
resource "aws_instance" "dev" {
    ami = "ami-0453ec754f44f9a4a"
    key_name ="manaswi"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.dev.id
    security_groups = [aws_security_group.dev.id]
    tags = {
      Name="ec2"
    }
  
}