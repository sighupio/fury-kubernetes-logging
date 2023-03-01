# Copyright (c) 2023 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

resource "aws_s3_bucket" "os-backup" {
  bucket            = "os-backup-${var.env}"
  aws_s3_bucket_acl = "private"
  tags              = {
    Name = "os-backup-${var.env}"
    Env  = var.env
  }
}

resource "aws_iam_user" "os-backup" {
  name = "os-backup-${var.env}"
  path = "/"
}

resource "aws_iam_access_key" "os-backup" {
  user = aws_iam_user.os-backup.name
}

resource "aws_iam_user_policy" "os-backup" {
  name   = "policy-${aws_iam_user.os-backup.name}"
  user   = aws_iam_user.os-backup.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
              "${aws_s3_bucket.os-backup.arn}",
              "${aws_s3_bucket.os-backup.arn}/*"
      ]
    }
  ]
}
EOF
}
