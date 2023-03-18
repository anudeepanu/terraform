resource "aws_eip" "test" {
  vpc      = true
}

resource "aws_nat_gateway" "test" {
  allocation_id = aws_eip.test.id
  subnet_id     = aws_subnet.pub.id

  tags = {
    Name = "gw NAT"
  }


  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.test]
}
