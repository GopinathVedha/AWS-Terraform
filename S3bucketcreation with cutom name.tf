


resource "aws_s3_bucket" "DemoBucket" {
  bucket = "${var.bucket}"
  acl = "private"

  tags = {
    Name        = "GoSowaDemoBucket"
   
  }
}


variable "bucket" {}
