
resource "aws_instance" "Data" {
    ami = data.aws_ami.Windows.id
    instance_type = "t2.micro"
    subnet_id = "subnet-9735d7df"
    key_name = "Demo"
    availability_zone = "ap-southeast-2a"
    vpc_security_group_ids = ["sg-55d56121"]

    root_block_device {
        volume_size = 120
        volume_type = "gp3"
        delete_on_termination = true
    }
    tags = {
        Name = "Windows Server"
    }

}


resource "aws_ebs_volume" "Windowsvolume" {
    availability_zone = "ap-southeast-2a"
    size = 30
    type = "gp3"
    

    tags = {
        Name = "D"
    }
}

resource "aws_volume_attachment" "Volattach" {
    device_name = "xvdb"
    volume_id = aws_ebs_volume.Windowsvolume.id
    instance_id = aws_instance.Data.id

}

resource "aws_instance" "APP" {
    ami = data.aws_ami.Linux.id
    instance_type = "t2.micro"
    subnet_id = "subnet-12bb4b74"
    key_name = "Demo"
    availability_zone = "ap-southeast-2b"
    vpc_security_group_ids = ["sg-55d56121"]

     root_block_device {
        volume_size = 120
        volume_type = "gp3"
        delete_on_termination = true
    }
    tags = {
        Name = "RHEL SERVER"
    }
}
resource "aws_ebs_volume" "LinuxVolume" {
    availability_zone = "ap-southeast-2b"
    size = 30
    type = "gp3"

    tags = {
        Name = "D"
    }
}

resource "aws_volume_attachment" "attachStorage" {
    device_name = "/dev/sdb"
    volume_id = aws_ebs_volume.LinuxVolume.id
    instance_id = aws_instance.APP.id

}
