terraform {
  backend "s3" {
    bucket = "gosowa"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}


resource "aws_instance" "web" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  subnet_id     = "subnet-04c2509c0e4ab88c0"

  tags = {
    Name = "DemoImport"
  }
}
