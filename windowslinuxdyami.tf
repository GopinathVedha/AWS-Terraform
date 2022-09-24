data "aws_ami" "Windows" {
  most_recent      = true
  owners           = ["amazon"]

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

data "aws_ami" "Linux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["RHEL_HA-8.4.0_*"]
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
    ami = data.aws_ami.Windows.id
    instance_type = "t2.micro"
}

resource "aws_instance" "example" {
    ami = data.aws_ami.Linux.id
    instance_type = "t2.micro"
}
