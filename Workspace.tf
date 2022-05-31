EC2 creation with different workspace (Prod,Dev and default)


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
  instance_type = lookup(var.instance_type,terraform.workspace)
  
 }
 
 Varibale "instance_type" {
  type = map
  
  default = {
    default = "t3.micro"
    dev = "t3.large"
    prod = "t2.micro"
    
  }
  }

  tags = {
    Name = $(terraform.workspace-instance)
  }
}
