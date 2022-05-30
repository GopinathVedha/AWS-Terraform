### EC2 with dynamic AMI ID###


data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]

}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"

  tags = {
    Name = "Linux Server"
  }
}
