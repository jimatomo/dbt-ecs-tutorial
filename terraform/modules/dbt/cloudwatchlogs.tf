#-------------------------------------
# CloudWatch Logs
#-------------------------------------

resource "aws_cloudwatch_log_group" "cloudwatch_logs_group_task_run_001" {
  name              = "/ecs/${var.dbt_ecs_tutorial_task_run_001_family}"
  retention_in_days = var.cloudwatch_logs_group_retention_task
}

resource "aws_cloudwatch_log_group" "cloudwatch_logs_group_task_docs_001" {
  name              = "/ecs/${var.dbt_ecs_tutorial_task_docs_001_family}"
  retention_in_days = var.cloudwatch_logs_group_retention_task
}
