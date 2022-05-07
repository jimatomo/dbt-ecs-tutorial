######################################
# Module: dbt
######################################

######################################
# codebuild.tf
######################################

#-------------------------------------
# CodeBuild project
#-------------------------------------

variable "codebuild_project_name" {
  description = "CodeBuild Project Name"
  type        = string
  default     = "dbt_ecs_tutorial"
}

variable "codebuild_build_timeout" {
  description = "CodeBuild build timeout"
  type        = number
  default     = 5
}

variable "codebuild_log_group" {
  description = "CloudWatch Logs Log Group Name for CodeBuild"
  type        = string
  default     = "/aws/codebuild/dbt_ecs_tutorial"
}

variable "codebuild_log_stream" {
  description = "CloudWatch Logs Log Stream Name for CodeBuild"
  type        = string
  default     = "dbt_container_build"
}

variable "dbt_ecs_codebuild_001_role_arn" {
  description = "CodeBuild Role Arn (This variable will be overwritten)"
  type = string
  default = ""
}

######################################
# codecommit.tf
######################################

#-------------------------------------
# CodeCommit Repository
#-------------------------------------

variable "codecommit_repository_name" {
  description = "CodeCommit Repository Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial"
}


######################################
# codepipeline.tf
######################################

#-------------------------------------
# Codepipeline
#-------------------------------------

variable "codepipeline_name" {
  description = "CodePipeline Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial"
}

variable "codepipeline_source_stage_name" {
  description = "[Source] CodePipeline Stage Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_source_stage"
}

variable "codepipeline_source_stage_action_name" {
  description = "[Source] CodePipeline Stage Action Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_source_stage_action"
}

variable "codepipeline_build_stage_name" {
  description = "[Source] CodePipeline Stage Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_build_stage"
}

variable "codepipeline_build_stage_action_name" {
  description = "[Source] CodePipeline Stage Action Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_build_stage_action"
}

variable "dbt_ecs_codepipeline_001_role_arn" {
  description = "CodePipeline Role Arn (This variable will be overwritten)"
  type = string
  default = ""
}

######################################
# ecs.tf
######################################

#-------------------------------------
# ECS Cluster
#-------------------------------------

variable "dbt_ecs_tutorial_ecs_cluster_name" {
  description = "ECS Cluster Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_ecs_cluster_001"
}

#-------------------------------------
# ECS Task
#-------------------------------------

#-------------------------------------
# dbt run task
variable "dbt_ecs_tutorial_task_docs_001_family" {
  description = "[dbt docs] ECS Task Definition Family Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_task_docs_001"
}

variable "dbt_ecs_tutorial_task_docs_001_cpu" {
  description = "[dbt docs] ECS Task CPU capacity for dbt tutorial"
  type        = number
  default     = 256
}

variable "dbt_ecs_tutorial_task_docs_001_memory" {
  description = "[dbt docs] ECS Task Memory capacity for dbt tutorial"
  type        = number
  default     = 512
}

variable "dbt_ecs_task_001_role_arn" {
  description = "Task Role Arn (This variable will be overwritten)"
  type = string
  default = ""
}

variable "dbt_ecs_task_exec_001_role_arn" {
  description = "Task Role Arn (This variable will be overwritten)"
  type = string
  default = ""
}

#-------------------------------------
# dbt run task
variable "dbt_ecs_tutorial_task_run_001_family" {
  description = "[dbt run] ECS Task Definition Family Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_task_run_001"
}

variable "dbt_ecs_tutorial_task_run_001_cpu" {
  description = "[dbt run] ECS Task CPU capacity for dbt tutorial"
  type        = number
  default     = 256
}

variable "dbt_ecs_tutorial_task_run_001_memory" {
  description = "[dbt run] ECS Task Memory capacity for dbt tutorial"
  type        = number
  default     = 512
}

#-------------------------------------
# ECR
#-------------------------------------

variable "dbt_ecs_tutorial_ecr_001_name" {
  description = "[Base Image] ECR Repository Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_ecr_base"
}

variable "dbt_ecs_tutorial_ecr_002_name" {
  description = "[Dbt Image] ECR Repository Name for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_ecr"
}


######################################
# eventbridge.tf
######################################

#-------------------------------------
# EventBridge
#-------------------------------------

variable "events_rule_codepipeline_name" {
  description = "Event rule name (target CodePipeline) for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_events_rule_codepipeline_001"
}

variable "events_target_id_codepipeline" {
  description = "Event target id (target CodePipeline) for dbt tutorial"
  type        = string
  default     = "dbt_ecs_tutorial_events_target_codepipeline_001"
}

variable "dbt_ecs_eventbridge_codepipeline_001_role_arn" {
  description = "EventBridge Role Arn (This variable will be overwritten)"
  type = string
  default = ""
}

######################################
# s3.tf
######################################

#-------------------------------------
# For CodePipeline Artifact Store
#-------------------------------------

variable "s3_bucket_codepipeline_artifact_prefix" {
  description = "CodePipeline Artifact Store S3 Bucket prefix for dbt tutorial"
  type        = string
  default     = "codepipeline-ap-northeast-1-"
}

variable "s3_bucket_docs_prefix" {
  description = "dbt docs hosting S3 Bucket prefix for dbt tutorial"
  type        = string
  default     = "dbt-ecs-tutorial-"
}
