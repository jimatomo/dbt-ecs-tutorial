#-----------------------------------------
# Security Group
#-----------------------------------------

resource "aws_security_group" "dwh" {
  name        = var.rds_instance_security_group_name
  description = "dbt-ecs-tutorial dwh security group"
  vpc_id      = aws_vpc.target_vpc.id

  ingress {
    from_port       = var.rds_instance_sg_ingress_001_from_port
    to_port         = var.rds_instance_sg_ingress_001_to_port
    protocol        = var.rds_instance_sg_ingress_001_protocol
    security_groups = [aws_security_group.dbt.id]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }  
}

resource "aws_security_group" "dbt" {
  name        = var.dbt_container_security_group_name
  description = "dbt-ecs-tutorial dbt security group"
  vpc_id      = aws_vpc.target_vpc.id

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }  
}

