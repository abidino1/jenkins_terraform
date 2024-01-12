resource "aws_s3_bucket" "my_unique_bucket" {
  bucket = "my-unique-bucket-${random_id.bucket_id.hex}"
  // Other bucket configurations can be added here
}

resource "random_id" "bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_unique_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = [
          "${aws_s3_bucket.my_unique_bucket.arn}/*",
          aws_s3_bucket.my_unique_bucket.arn
        ]
        Principal = "*"
        Condition = {
          IpAddress = {
            "aws:SourceIp": ["24.130.157.178/24", "67.164.82.76/24"]
          }
        }
      }
    ]
  })
}

