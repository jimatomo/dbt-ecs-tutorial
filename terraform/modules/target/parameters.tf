#-----------------------------------------
# SSM Parameter Store
#-----------------------------------------

resource "aws_ssm_parameter" "rds_instance_password" {
  name        = var.paramter_store_name_rds_instance_password
  description = "RDS mastasr user password"
  type        = "SecureString"
  value       = random_password.rds_instance_password.result
}

resource "aws_ssm_parameter" "secret" {
  name        = var.paramter_store_name_rds_instance_address
  description = "RDS address"
  type        = "String"
  value       = aws_db_instance.dwh.address
}



