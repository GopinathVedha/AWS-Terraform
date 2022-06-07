locals {
  ingress_rules = [{
    port        = 0
    description = "Ingress rules for port 0"
    },
    {
      port        = 22
      description = "Ingree rules for port 22"
  }]
}



data "aws_vpc" "my-vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "main" {
  name   = "resource_with_dynamic_block"
  vpc_id = data.aws_vpc.my-vpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "AWS security group dynamic block"
  }
}


resource "aws_instance" "ec2_example" {

    ami = "ami-0022f774911c1d690"  
    instance_type = "t2.micro" 
    key_name= "key-for-demo"
    vpc_security_group_ids = [aws_security_group.main.id]


    provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("/home/gopinath/Git/Keypair/key-for-demo")
      timeout     = "4m"
   }

}

resource "aws_key_pair" "deployer" {
  key_name   = "key-for-demo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDO7Oc+iF6vp9a4FDdr1TvTGZwRM1NjKbVaj1EZ+vPHA2rFy4C1esvX2QksoxBuYBlpr+DjqWptDSc3TAPmE6ifnugxmJzjuxtg1ez1OTf92k618KxYopqSHvrL09gBh5boiOamFRjKRyIDlIKwA8nSDd38gzOUrZMmTx8hMebGhse35Q35HgbcSUQtc2D8ngkNm29QHZwczxhf1GXbxxT7cruJ1zN6FWqiUpQMoLCAAAOq1hodgUnPCMAY/y/iogDxCZTDDgzUCsQFMICEoVdiq9ilyte4cqrZYepoMJeX5lbOUUKKPH73UxVDe3LlxSxx/M+rp59MayuKT/Es0aaF8cT8j3u2MIDZOEEDKZMGYWNuSIMmrM3IEgHFluy80Iq+LX4BLIB4hNdKMt5PrzcPoPqFmeYolwJ8BvJMTxdImlNeyHlqNQK9zn53iknYa7ZSW6JsLy6DLFImCrqISEuXDjrkFqWAGe1QFCBp3/OzKmGS2rsJqc7qHzQ21omvdmM= gopinath@ubuntu"
}
