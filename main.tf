terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
  }
  required_version = ">= 1.2.0"
}
provider "aws" {
    profile = "default"
    region = "us-east-1"
  
}

##vpc
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
      Name =  var.vpc_name
    }
  
}

##subnet
resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr

    tags = {
      Name = var.subnet_name
    }
  
}

##Internet Gateway
resource "aws_internet_gateway" "my_IGW" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
      Name = var.IGW_name
    }
  
}

## Create a route table
resource "aws_route_table" "my_RT" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_IGW.id
    }

    tags = {
      Name = var.IGW_name
    }
  
}
##Associate route table with subnet

resource "aws_route_table_association" "public-RT-assoc" {
    subnet_id = aws_subnet.my_subnet.id
    route_table_id = aws_route_table.my_RT.id
    
}
## Create AWS security Group
resource "aws_security_group" "my_sg" {
    name = "HTTP"
    vpc_id = aws_vpc.my_vpc.id

    ingress  {
        from_port = 80
        to_port =80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

  
}

##Create ec2 instance
resource "aws_instance" "ec2-server" {
    ami = var.ec2_ami
    instance_type = "t2.xlarge"
    count =  2
    subnet_id = aws_subnet.my_subnet.id
    vpc_security_group_ids = [ aws_security_group.my_sg.id ]
    #   associate_public_ip_address = true
      tags = {
        Name = "${var.ec2_name}- ${count.index +1}"
      }

}