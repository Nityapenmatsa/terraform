variable "ami" {
    description = "inserting ami value"
    type = string
    default = "ami-0453ec754f44f9a4a"
}
variable "type" {
    description = "inserting value for instance type"
    type = string
    default = "t2.micro"
}
variable "key_name" {
    description = "inserting key name"
    type = string
    default = "manaswi"
  
}