resource "aws_route_table" "test" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test.id
  }




  tags = {
    Name = "publicroute"
  }
}

resource "aws_route_table_association" "test" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.test.id
}
resource "aws_default_route_table" "test" {
  default_route_table_id = aws_vpc.test.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.test.id
  }


  tags = {
    Name = "test-pvt"
  }
}

resource "aws_route_table_association" "test2" {
  #vpc_id         = aws_vpc.test.id
  route_table_id = aws_default_route_table.test.id
  subnet_id      = aws_subnet.private.id

}
