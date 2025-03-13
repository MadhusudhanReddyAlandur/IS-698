provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-04aa00acb1165b32a"
  instance_type = "t2.micro"
  key_name      = "MyKeyPair"

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}