resource "aws_security_group" "postgresql" {
  name        = "postgress"
  #description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0769efd0e463b29e2" 

  ingress {
   #description      = "TLS from VPC"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/8", "100.0.0.0/8"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "postgress"
  }
}
