#-------------------------------------
# ECS Cluster
#-------------------------------------

resource "aws_ecs_cluster" "dbt_ecs_tutorial_ecs_cluster" {
  name = var.dbt_ecs_tutorial_ecs_cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "dbt_ecs_tutorial_ecs_cluster_provider" {
  cluster_name = aws_ecs_cluster.dbt_ecs_tutorial_ecs_cluster.name

  capacity_providers = ["FARGATE"]
}

#-------------------------------------
# ECS Task
#-------------------------------------

#-------------------------------------
# dbt docs task
resource "aws_ecs_task_definition" "dbt_ecs_tutorial_task_docs_001" {
  family                   = var.dbt_ecs_tutorial_task_docs_001_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.dbt_ecs_tutorial_task_docs_001_cpu
  memory                   = var.dbt_ecs_tutorial_task_docs_001_memory
  task_role_arn            = var.dbt_ecs_task_001_role_arn
  execution_role_arn       = var.dbt_ecs_task_exec_001_role_arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "${var.dbt_ecs_tutorial_task_docs_001_family}_container",
    "image": "${aws_ecr_repository.dbt_ecs_tutorial_ecr_001.repository_url}",
    "essential": true,
    "command": "${var.dbt_ecs_tutorial_task_docs_001_command}"
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

#-------------------------------------
# dbt run task
resource "aws_ecs_task_definition" "dbt_ecs_tutorial_task_run_001" {
  family                   = var.dbt_ecs_tutorial_task_run_001_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.dbt_ecs_tutorial_task_run_001_cpu
  memory                   = var.dbt_ecs_tutorial_task_run_001_memory
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "${var.dbt_ecs_tutorial_task_run_001_family}_container",
    "image": "${aws_ecr_repository.dbt_ecs_tutorial_ecr_001.repository_url}",
    "essential": true,
    "command": "${var.dbt_ecs_tutorial_task_run_001_command}"
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}


#-------------------------------------
# ECR
#-------------------------------------

resource "aws_ecr_repository" "dbt_ecs_tutorial_ecr_001" {
  name                 = var.dbt_ecs_tutorial_ecr_001_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "dbt_ecs_tutorial_ecr_002" {
  name                 = var.dbt_ecs_tutorial_ecr_002_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
