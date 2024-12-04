resource "aws_vpc" "nitya-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name= "project-k-vpc"
  }
}

#create public subnet
resource "aws_subnet" "nitya-sb" {
    vpc_id = aws_vpc.nitya-vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true  
    tags = {
      Name= "project-k-subnet"
    }
  
}

#create private subnet
resource "aws_subnet" "nitya-sb-prvt" {
    vpc_id = aws_vpc.nitya-vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name= "project-k- prvt-subnet"
    }
  
}
#create internet gateway
resource "aws_internet_gateway" "nitya-ig" {
    vpc_id = aws_vpc.nitya-vpc.id
    tags = {
      Name= "ig"
    }
  
}

#create elastic ip
resource "aws_eip" "nitya-eip" {
  vpc = true
}

#create nat gateway
resource "aws_nat_gateway" "nitya-nat" {
 allocation_id = aws_eip.nitya-eip.id
  subnet_id     = aws_subnet.nitya-sb.id
  tags = {
    Name = "nitya-nat"
  }
}

#creation of routr table for prvt routing
resource "aws_route_table" "nitya-private-route" {
  vpc_id = aws_vpc.nitya-vpc.id
  tags = {
    Name = "project-k-private-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nitya-nat.id
  }
}

#creation of subnet associations to prvt
resource "aws_route_table_association" "private-subnet-association" {
  route_table_id = aws_route_table.nitya-private-route.id
  subnet_id      = aws_subnet.nitya-sb-prvt.id
}
#create route table and edit routes fo public
resource "aws_route_table" "nitya-route" {
    vpc_id = aws_vpc.nitya-vpc.id
    tags = {
      Name= "project-k-rt"
    }
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nitya-ig.id
}
  
}

#create subnet associations for public
resource "aws_route_table_association" "nitya" {
    route_table_id = aws_route_table.nitya-route.id
    subnet_id = aws_subnet.nitya-sb.id


}

#create security groups
resource "aws_security_group" "nitya-sg" {
    name = "allow all traffic"
    vpc_id = aws_vpc.nitya-vpc.id
    tags = {
      Name= "sg-project-k"
    }
ingress{
    description = "inbound traffic"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
}   
egress{
    description = "outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}   
}
#create an ec2 pub
resource "aws_instance" "name"{
    ami = "ami-0453ec754f44f9a4a"
    key_name = "manaswi"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.nitya-sb.id
    vpc_security_group_ids = [aws_security_group.nitya-sg.id]
    associate_public_ip_address = true  
    
    tags = {
      Name= "project-k-ec2"
    }
}    
    
    
#create an ec2 prvt
resource "aws_instance" "name-prvt"{
    ami = "ami-0453ec754f44f9a4a"
    key_name = "manaswi"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.nitya-sb-prvt.id
    vpc_security_group_ids = [aws_security_group.nitya-sg.id]  
    
    tags = {
      Name= "project-k-ec2-prvt"
    }
}