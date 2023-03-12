resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "testigw"
  }
}

#resource "aws_internet_gateway_attachment" "test" {
  #internet_gateway_id = aws_internet_gateway.test.id
  #vpc_id              = aws_vpc.test.id
#}
