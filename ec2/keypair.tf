resource "aws_key_pair" "tf-key-pair" {
key_name = "prac"
public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}
resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "home/ubntu/prac.pem"
}
#filename = < location where you want to store pem"
