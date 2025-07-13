provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}



resource "aws_instance" "minikube" {
  ami           = "ami-0150ccaf51ab55a51"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.all_open.id]

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -a -G docker ec2-user
    docker --version
    curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    minikube start


  EOF

  tags = {
    Name = "Mini-kube"
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "my-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyCYYB5k90OVzwAw3E3G7iEqBK9yK41LWmjrKYMX/illbnJdiVtUMtCJkwepXn7VlQeUYaLAlHKx8wf4GummcEbjnzpN6+RrT/yKGT7AD"
}

resource "aws_security_group" "all_open" {
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


output "public_ip" {
  value = aws_instance.minikube.public_ip
}



