terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket         = "tf_backend_s3_will_be_overwritten"
    dynamodb_table = "terraform-state-lock-for-dbt-ecs-tutorial"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1" # S3やDynamoDBが作成されているリージョン
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

module "iam" {
  source = "../modules/iam"

  dbt_codepipeline_arn                 = module.dbt.dbt_codepipeline_arn
  iam_dbt_ecs_001_resource_bucket_name = module.dbt.dbt_docs_hosting_s3_bucket_name

  # variablesを上書きする
}

module "target" {
  source = "../modules/target"


  # variablesを上書きする
}

module "dbt" {
  source = "../modules/dbt"

  # outputは確実にvarとして定義する（output名と同じ名前で参照している）
  dbt_ecs_task_001_role_arn                     = module.iam.dbt_ecs_task_001_role_arn
  dbt_ecs_tack_exec_001_role_arn                = module.iam.dbt_ecs_tack_exec_001_role_arn
  dbt_ecs_stepfunctions_001_role_arn            = module.iam.dbt_ecs_stepfunctions_001_role_arn
  dbt_ecs_codebuild_001_role_arn                = module.iam.dbt_ecs_codebuild_001_role_arn
  dbt_ecs_codepipeline_001_role_arn             = module.iam.dbt_ecs_codepipeline_001_role_arn
  dbt_ecs_eventbridge_codepipeline_001_role_arn = module.iam.dbt_ecs_eventbridge_codepipeline_001_role_arn

  # variablesを上書きする
}
