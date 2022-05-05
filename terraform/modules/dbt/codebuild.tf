#-------------------------------------
# Account ID & Region
#-------------------------------------

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

#-------------------------------------
# CodeBuild
#-------------------------------------

resource "aws_codebuild_project" "dbt_ecs_tutorial_codebuild" {
  name          = var.codebuild_project_name
  description   = "dbt_ecs_tutorial_codebuild_project"
  build_timeout = var.codebuild_build_timeout
  service_role  = var.dbt_ecs_task_001_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    privileged_mode             = "true"

    # 環境変数があればここに入れるが
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "${data.aws_region.current}"
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "${data.aws_caller_identity.current}"
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = "${var.dbt_ecs_tutorial_ecr_002_name}"
    } 
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.codebuild_log_group
      stream_name = var.codebuild_log_stream
    }
  }

  source {
    type            = "CODECOMMIT"
    location        = var.codecommit_repository_name
    git_clone_depth = 1
  }

  source_version = "master"
}