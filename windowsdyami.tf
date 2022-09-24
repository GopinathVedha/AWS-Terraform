data "aws_ami" "test" {
  most_recent      = true
  owners           = ["801119661308"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "test" {
    ami = data.aws_ami.test.id
    instance_type = "t2.micro"
}
