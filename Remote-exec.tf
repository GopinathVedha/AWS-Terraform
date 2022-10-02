provisioner "remote-exec" {
        connection {
        type = "ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file("/home/gopinath/Downloads/Demo.pem")
        }
       inline = [
        "sudo hostnamectl set-hostname 'gopinath-server'"
       ]
        
    }
 depends_on = [aws_instance.example]
