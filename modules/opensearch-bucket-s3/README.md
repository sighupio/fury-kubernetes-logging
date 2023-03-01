# Terraform module for creating an S3 bucket for OpenSearch

This module creates an S3 bucket for OpenSearch with the a policy that allows OpenSearch to write to it with a specific credentials set.


## Usage

import the module with the FuryFile:

  ```yaml
  bases:
    - name: logging/opensearch-bucket-s3
      version: "v3.0.1"

  modules:
    - name: opensearch-bucket-s3
  ```

and then use it in your terraform code:

  ```hcl
  module "opensearch_bucket_s3" {
    source = "../vendor/katalog/logging/opensearch-bucket-s3"
    region = "eu-west-1"
    env = "dev"
  }

  output "opensearch_bucket_s3" {
    value = module.os_backup_secret
  }
  ```

> Note: adjust paths and variable values to your needs as this is just an example

## Outputs

Now you can use the terraform output command to create the secret env file that will be used by the opensearch module:

  ```bash
  terraform output --raw os_backup_secret > ../manifests/<env>/logging/secrets/secret-snapshot-s3.env
  ```

Now you are ready to deploy the opensearch module with the snapshot repository configured!
