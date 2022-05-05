#-------------------------------------
# CodePipeline
#-------------------------------------

resource "aws_codepipeline" "dbt_ecs_tutorial_codepipeline" {
  name     = var.codepipeline_name
  role_arn = var.dbt_ecs_codepipeline_001_role_arn

  artifact_store {
    location = aws_s3_bucket.dbt_ecs_tutorial_codepipeline_artifact.bucket
    type     = "S3"
  }

  stage {
    name = var.codepipeline_source_stage_name

    action {
      name             = var.codepipeline_source_stage_action_name
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName       = var.codecommit_repository_name
        BranchName           = "main"
        PollForSourceChanges = "false"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = var.codepipeline_build_stage_name

    action {
      name             = var.codepipeline_build_stage_action_name
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }
}



