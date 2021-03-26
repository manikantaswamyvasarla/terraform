
 provider "aws" {
  region     = "us-east-2"
  access_key = "AKIA5ST7RZWSPAGYKO7H"
  secret_key = "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"
}
resource "aws_instance" "us-east-2" {
  ami           = "ami-089c6f2e3866f0f14" # us-west-2
  instance_type = "t2.micro"
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA5ST7RZWSPAGYKO7H"
  secret_key = "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"
  alias = "uswest2"
}

resource "aws_instance" "us-west-2" {
  ami           = "ami-05b622b5fa0269787" # us-west-2
  instance_type = "t2.micro"
  provider=aws.uswest2
}

resource "aws_s3_bucket" "myfirstbucket" {
  bucket = "s3-ec2-terraform-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
versioning{
  enabled=true
     }
}
resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev-vpc"
  }
}
resource "aws_subnet" "sub" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dev-subnet"
  }
}
