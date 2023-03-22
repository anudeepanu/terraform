resource "aws_vpc" "test" {
  cidr_block       = "20.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test"
  }
}


resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "20.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "pub"
  }

}

resource "aws_subnet" "pvt" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "20.0.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "pvt"
  }
}
~                                        
