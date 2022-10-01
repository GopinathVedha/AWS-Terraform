To import Instances with attached ebs volumes:

To import instance:
    terraform import aws_instance.DATA i-004e7455734e25bf6

To import volume :
    terraform import aws_ebs_volume.Windowsvolume1 vol-099dba2da02609dde
    
    
 To import volume attachment
terraform import aws_volume_attachment.Volattach1 xvdb:vol-099dba2da02609dde:i-004e7455734e25bf6
    command + device name + volume ID + Instance ID
