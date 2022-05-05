#-----------------------------------------
# password
#-----------------------------------------

resource "random_password" "rds_instance_password" {
  length = 16                   # パスワードの長さ
  special = true                # 特殊文字を含む
  override_special = "_$!+-"    # 特殊文字のリスト
}

#-----------------------------------------
# RDS
#-----------------------------------------

resource "aws_db_parameter_group" "dwh_parameter_group" {
  name = var.rds_parameter_group_name
  family = var.rds_parameter_group_family
}

resource "aws_db_subnet_group" "dwh_subnet_group" {
  name = var.rds_subnet_group_name
  subnet_ids = [ aws_subnet.target_private_subnet[0].id, aws_subnet.target_private_subnet[1].id ]
}

resource "aws_db_instance" "dwh" {
  allocated_storage      = var.rds_instance_storage_size
  engine                 = var.rds_instance_engine
  engine_version         = var.rds_instance_engine_version
  instance_class         = var.rds_instance_class
  username               = var.rds_instance_username
  password               = random_password.rds_instance_password.result
  parameter_group_name   = aws_db_parameter_group.dwh_parameter_group.id
  db_subnet_group_name   = aws_db_subnet_group.dwh_subnet_group.id
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.dwh.id]
}
