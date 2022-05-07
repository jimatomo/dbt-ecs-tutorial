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
data "template_file" "container_definitions_docs" {
  template = "${file("${path.module}/container_definitions_docs.json")}"
  vars = {
    name_var = "${var.dbt_ecs_tutorial_task_docs_001_family}_container"
    image_var = "${aws_ecr_repository.dbt_ecs_tutorial_ecr_002.repository_url}:latest"
  }
}

resource "aws_ecs_task_definition" "dbt_ecs_tutorial_task_docs_001" {
  family                   = var.dbt_ecs_tutorial_task_docs_001_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.dbt_ecs_tutorial_task_docs_001_cpu
  memory                   = var.dbt_ecs_tutorial_task_docs_001_memory
  task_role_arn            = var.dbt_ecs_task_001_role_arn
  execution_role_arn       = var.dbt_ecs_task_exec_001_role_arn
  container_definitions    = "${data.template_file.container_definitions_docs.rendered}"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

#-------------------------------------
# dbt run task
data "template_file" "container_definitions_run" {
  template = "${file("${path.module}/container_definitions_docs.json")}"
  vars = {
    name_var = "${var.dbt_ecs_tutorial_task_run_001_family}_container"
    image_var = "${aws_ecr_repository.dbt_ecs_tutorial_ecr_002.repository_url}:latest"
  }
}

resource "aws_ecs_task_definition" "dbt_ecs_tutorial_task_run_001" {
  family                   = var.dbt_ecs_tutorial_task_run_001_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.dbt_ecs_tutorial_task_run_001_cpu
  memory                   = var.dbt_ecs_tutorial_task_run_001_memory
  task_role_arn            = var.dbt_ecs_task_001_role_arn
  execution_role_arn       = var.dbt_ecs_task_exec_001_role_arn
  container_definitions    = "${data.template_file.container_definitions_run.rendered}"

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
