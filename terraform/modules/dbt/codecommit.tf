#-------------------------------------
# CodeCommit
#-------------------------------------

resource "aws_codecommit_repository" "dbt_ecs_tutorial_codecommit_repos" {
  repository_name = var.codecommit_repository_name
  description     = "This is the dbt ECS tutorial Repository"
  default_branch  = "main"
}
