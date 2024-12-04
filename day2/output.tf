output "name" {
    description = "print public ip"
    value = aws_instance.name.public_ip
  
}