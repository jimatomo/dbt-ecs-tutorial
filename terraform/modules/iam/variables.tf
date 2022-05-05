######################################
# Module: iam
######################################

######################################
# iam.tf
######################################

#-------------------------------------
# IAM Policy
#-------------------------------------

#-------------------------------------
# dbt_ecs_task_001
variable "iam_dbt_ecs_001_resource_parameter_prefix" {
  description = "ssm parameter name prefix"
  type = string
  default = "dbt-ecs-tutorial"
}

variable "iam_dbt_ecs_001_resource_bucket_name" {
  description = "bucket name (This variable will be overwritten)"
  type = string
  default = "dbt-ecs-tutorial*"
}

variable "iam_policy_name_dbt_ecs_task_001" {
  description = "iam policy name of dbt ecs task"
  type = string
  default = "dbt-ecs-tutorial-ecs-task-001"
}

variable "iam_policy_path_dbt_ecs_task_001" {
  description = "iam policy path of dbt ecs task"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_exec_001
variable "dbt_ecs_task_prefix" {
  description = "dbt ecs task name prefix"
  type = string
  default = "dbt-ecs-task"
}

variable "iam_policy_name_dbt_ecs_tack_exec_001" {
  description = "iam policy name of dbt ecs task execution"
  type = string
  default = "dbt-ecs-tutorial-ecs-task-exec-001"
}

variable "iam_policy_path_dbt_ecs_task_exec_001" {
  description = "iam policy path of dbt ecs task execution"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_stepfunctions_001
variable "step_func_dbt_ecs_task_rule_name" {
  description = "Events Rule name"
  type = string
  default = "StepFunctionsGetEventsForECSTaskRule"
}

variable "dbt_ecs_tutorial_sns_topic_name" {
  description = "SNS topic name"
  type = string
  default = "sns-topic-dbt-ecs-tutorial"
}

variable "iam_policy_name_dbt_ecs_stepfunctions_001_ecs" {
  description = "iam policy name of Step Functions (ECS)"
  type = string
  default = "dbt-ecs-tutorial-stepfunctions-001-ecs"
}

variable "iam_policy_path_dbt_ecs_stepfunctions_001_ecs" {
  description = "iam policy path of Step Functions (ECS)"
  type = string
  default = "/"
}

variable "iam_policy_name_dbt_ecs_stepfunctions_001_sns" {
  description = "iam policy name of Step Functions (SNS)"
  type = string
  default = "dbt-ecs-tutorial-stepfunctions-001-sns"
}

variable "iam_policy_path_dbt_ecs_stepfunctions_001_sns" {
  description = "iam policy path of Step Functions (SNS)"
  type = string
  default = "/"
}

variable "iam_policy_name_dbt_ecs_stepfunctions_001_xray" {
  description = "iam policy name of Step Functions (Xray)"
  type = string
  default = "dbt-ecs-tutorial-stepfunctions-001-xray"
}

variable "iam_policy_path_dbt_ecs_stepfunctions_001_xray" {
  description = "iam policy path of Step Functions (Xray)"
  type = string
  default = "/"
}

variable "iam_policy_name_dbt_ecs_stepfunctions_001_passrole" {
  description = "iam policy name of Step Functions (PassRole)"
  type = string
  default = "dbt-ecs-tutorial-stepfunctions-001-passrole"
}

variable "iam_policy_path_dbt_ecs_stepfunctions_001_passrole" {
  description = "iam policy path of Step Functions (PassRole)"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_codebuild_001
variable "iam_policy_name_dbt_ecs_codebuild_001" {
  description = "iam policy name of CodeBuild"
  type = string
  default = "dbt-ecs-tutorial-codebuild-001"
}

variable "iam_policy_path_dbt_ecs_codebuild_001" {
  description = "iam policy path of CodeBuild"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_codepipeline_001
variable "iam_policy_name_dbt_ecs_codepipeline_001" {
  description = "iam policy name of CodePipeline"
  type = string
  default = "dbt-ecs-tutorial-codepipeline-001"
}

variable "iam_policy_path_dbt_ecs_codepipeline_001" {
  description = "iam policy path of CodePipeline"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_eventbrige_001
variable "iam_policy_name_dbt_ecs_eventbridge_codepipeline_001" {
  description = "iam policy name of eventbridge for CodePipeline"
  type = string
  default = "dbt-ecs-tutorial-eventbridge-codepipeline-001"
}

variable "iam_policy_path_dbt_ecs_eventbridge_codepipeline_001" {
  description = "iam policy path of eventbridge for CodePipeline"
  type = string
  default = "/"
}

#-------------------------------------
# IAM Role
#-------------------------------------

#-------------------------------------
# dbt_ecs_task_001
variable "iam_role_name_dbt_ecs_task_001" {
  description = "iam role name of ECS Task"
  type = string
  default = "dbt-ecs-tutorial-dbt-ecs-task-001"
}

variable "iam_role_path_dbt_ecs_task_001" {
  description = "iam role path of ECS Task"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_task_exec_001
variable "iam_role_name_dbt_ecs_task_exec_001" {
  description = "iam role name of ECS Task Execution"
  type = string
  default = "dbt-ecs-tutorial-dbt-ecs-task-exec-001"
}

variable "iam_role_path_dbt_ecs_task_001" {
  description = "iam role path of ECS Task Execution"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_task_001
variable "iam_role_name_dbt_ecs_stepfunctions_001" {
  description = "iam role name of Step Functions"
  type = string
  default = "dbt-ecs-tutorial-dbt-ecs-stepfunctions-001"
}

variable "iam_role_path_dbt_ecs_stepfunctions_001" {
  description = "iam role path of Step Functions"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_codebuild_001
variable "iam_role_name_dbt_ecs_codebuild_001" {
  description = "iam role name of CodeBuild"
  type = string
  default = "dbt-ecs-tutorial-dbt-ecs-codebuild-001"
}

variable "iam_role_path_dbt_ecs_codebuild_001" {
  description = "iam role path of CodeBuild"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_codepipeline_001
variable "iam_role_name_dbt_ecs_codepipeline_001" {
  description = "iam role name of CodePipeline"
  type = string
  default = "dbt-ecs-tutorial-dbt-ecs-codepipeline-001"
}

variable "iam_role_path_dbt_ecs_codepipeline_001" {
  description = "iam role path of CodePipeline"
  type = string
  default = "/"
}

#-------------------------------------
# dbt_ecs_eventbrige_001
variable "iam_role_name_dbt_ecs_eventbridge_codepipeline_001" {
  description = "iam role name of EventBridge for CodePipeline"
  type = string
  default = "dbt-ecs-tutorial-eventbridge-codepipeline-001"
}

variable "iam_role_path_dbt_ecs_eventbridge_codepipeline_001" {
  description = "iam role path of EventBridge for CodePipeline"
  type = string
  default = "/"
}

