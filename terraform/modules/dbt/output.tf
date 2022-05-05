######################################
# Module: dbt
######################################

######################################
# codepipeline.tf
######################################

output "dbt_codepipeline_arn" {
  value       = aws_codepipeline.dbt_ecs_tutorial_codepipeline.arn
  description = "dbt codepipeline arn"
}

output "dbt_docs_hosting_s3_bucket_name" {
  value       = aws_s3_bucket.dbt_ecs_tutorial_docs_hosting.id
  description = "dbt hosting S3 bucket name"
}
