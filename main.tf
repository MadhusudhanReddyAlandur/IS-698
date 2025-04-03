provider "aws" {
  region = "us-east-1"
}

# Step 1: Define variable for instance types
variable "instances" {
  type = map(string)
  default = {
    "web1" = "t2.micro"
    "web2" = "t3.micro"
    "web3" = "t2.small"
  }
}

# Step 2: Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-vpc"
  }
}

# Step 3: Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "terraform-subnet"
  }
}

# Step 4: Launch EC2 Instances with for_each
resource "aws_instance" "web" {
  for_each      = var.instances
  ami           = "ami-0a9a48ce4458e384e"
  instance_type = each.value
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = each.key
  }
}

