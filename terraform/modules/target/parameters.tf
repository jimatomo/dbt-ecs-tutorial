#-----------------------------------------
# SSM Parameter Store
#-----------------------------------------

resource "random_password" "rds_instance_password_001" {
  length           = 16
  special          = true
  override_special = "!#%&*()-_=+[]{}<>?"
}

resource "aws_ssm_parameter" "rds_instance_password" {
  name        = var.paramter_store_name_rds_instance_password
  description = "RDS mastasr user password"
  type        = "SecureString"
  value       = random_password.rds_instance_password_001.result
}

resource "aws_ssm_parameter" "secret" {
  name        = var.paramter_store_name_rds_instance_address
  description = "RDS address"
  type        = "String"
  value       = aws_db_instance.dwh.address
}



