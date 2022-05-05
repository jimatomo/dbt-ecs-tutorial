#!/bin/bash
set -e

CFN_TEMPLATE=terraform_backend_s3.yml
CFN_STACK_NAME=terraform-backend-s3

# Read variables
read -p "Enter unique S3 bucket name for Terraform Backend: " TF_S3_BUCKET_NAME

# Create S3 Bucket and DynamoDB
echo Create S3 Bucket and DynamoDB with Cloudformation ...
aws cloudformation deploy --stack-name ${CFN_STACK_NAME} --template-file ${CFN_TEMPLATE} \
  --parameter-overrides \
    S3BucketName=${TF_S3_BUCKET_NAME}

# Write Variable for Terraform
echo Write Variable for Terraform ...
cat << EOS > ../terraform/projects/backend.tf
variable "tf_backend_s3" {
  description = "S3 bucket name for Terraform Backend"
  type        = string
  default     = "${TF_S3_BUCKET_NAME}"
}
EOS

echo success