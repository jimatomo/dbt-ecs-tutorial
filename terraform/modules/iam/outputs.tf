######################################
# Module: iam
######################################

######################################
# iam.tf
######################################

#-------------------------------------
# Account ID & Region
#-------------------------------------

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "current_region" {
  value = data.aws_region.current.name
}

#-------------------------------------
# IAM Role
#-------------------------------------

output "dbt_ecs_task_001_role_arn" {
  value       =  aws_iam_role.dbt_ecs_task_001.arn
  description = "Role for dbt_ecs_task_001"
}

output "dbt_ecs_tack_exec_001_role_arn" {
  value       =  aws_iam_role.dbt_ecs_tack_exec_001.arn
  description = "Role for dbt_ecs_tack_exec_001"
}

output "dbt_ecs_stepfunctions_001_role_arn" {
  value       =  aws_iam_role.dbt_ecs_stepfunctions_001.arn
  description = "Role for dbt_ecs_stepfunctions_001"
}

output "dbt_ecs_codebuild_001_role_arn" {
  value       =  aws_iam_role.dbt_ecs_codebuild_001.arn
  description = "Role for dbt_ecs_codebuild_001"
}

output "dbt_ecs_codepipeline_001_role_arn" {
  value       =  aws_iam_role.dbt_ecs_codepipeline_001.arn
  description = "Role for dbt_ecs_codepipeline_001"
}

output "dbt_ecs_eventbridge_codepipeline_001_role_arn" {
  value       =  aws_iam_role.dbt_ecs_eventbridge_codepipeline_001.arn
  description = "Role for dbt_ecs_eventbridge_codepipeline_001"
}
