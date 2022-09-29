 connection {
        type = "ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file("/home/XXX/Downloads/XXX.pem")

       
    }
    provisioner "remote-exec" {
       inline = [
        "hostnamectl set-hostname 'gfs-server-03'"
       ]
        
    }
 depends_on = [aws_instance.XXX]
