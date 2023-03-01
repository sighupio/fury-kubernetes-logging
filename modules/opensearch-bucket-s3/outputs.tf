# Copyright (c) 2023 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

locals {
  os_backup_env_secret       = <<EOT
AWS_ACCESS_KEY_ID=${aws_iam_access_key.os-backup.id}
AWS_REGION=${var.region}
AWS_SECRET_ACCESS_KEY=${aws_iam_access_key.os-backup.secret}
S3_BUCKET_NAME=${aws_s3_bucket.os-backup.id}
EOT
}

output "os_backup_secret" {
  description = "Opensearch backup secret"
  value       = local.os_backup_env_secret
  sensitive   = true
}
