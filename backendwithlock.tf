terraform {
    backend "s3" {
      region = "ap-south-1"
      bucket = "test-s3-bucket-1"
      key    = "omegazyadav"
      dynamodb_table = "test-dynamodb-table-1"
    }
  }
