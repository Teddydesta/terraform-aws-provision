output "instance_id" {
     value = aws_instance.ec2-server
     description = "Id of the Ec2 Instance"
  
 }

# output "instance_public_ip" {
#     value = aws_instance.my_Instance.public_ip
#     description = "The Public Ip of Ec2 Instance"
  
# }