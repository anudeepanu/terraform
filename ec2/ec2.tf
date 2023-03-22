resource "aws_instance" "vm1"{
    ami = "ami-0f8ca728008ff5af4"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.pub.id
    vpc_security_group_ids = [aws_security_group.sshd.id]
    associate_public_ip_address = true
    key_name = aws_key_pair.tf-key-pair.id
    user_data = file("<location of userdata file>")
    tags = {
      Name = "test"
    }
}

output "ec2_global_ips" {
  value = ["${aws_instance.vm1.*.public_ip}"]
}

#in the userdat section indention place an important role
~                                                                                                                                             
~                                                         
