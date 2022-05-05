#-------------------------------------
# S3 Bucket
#-------------------------------------

# For CodePipeline Artifact Store
resource "aws_s3_bucket" "dbt_ecs_tutorial_codepipeline_artifact" {
  bucket_prefix = var.s3_bucket_codepipeline_artifact_prefix
}

# For CodePipeline Artifact Store
resource "aws_s3_bucket" "dbt_ecs_tutorial_docs_hosting" {
  bucket_prefix = var.s3_bucket_docs_prefix
}


