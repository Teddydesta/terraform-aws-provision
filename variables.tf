variable "vpc_cidr" {
    description = "Value of cidr range for VPC"
    type = string
    default = "10.0.0.0/16"
  
}
variable "vpc_name" {
    description = "value of name for VPC"
    type = string
    default = "myVPC"
  
}
variable "subnet_cidr" {
    description = "value of cidr range for subnet"
    type = string
    default = "10.0.1.0/24"

}
variable "subnet_name" {
    description = "value of the subnet Name"
    type = string
    default = "mySubnet"
  
}
variable "IGW_name" {
    description = "value for the name of IGW"
    type = string
    default = "myIGW"
  
}
variable "ec2_name" {
    description = "value of the name of Instance"
    type = string
    default = "myInstance"
  
}
variable "ec2_ami" {
    description = "value of the AMI ID"
    type = string
    default = "ami-04e5276ebb8451442"
  
}