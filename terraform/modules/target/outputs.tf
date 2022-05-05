######################################
# Module: target
######################################

######################################
# vpc.tf
######################################

output "target_vpc_id" {
  value       = aws_vpc.target_vpc.id
  description = "Target VPC ID"
}

output "target_public_subnet_id_list" {
  value       = aws_subnet.target_public_subnet.*.id
  description = "List of Target public subnet ID"
}

######################################
# rds.tf
######################################

output "dwh_password" {
  value       = aws_db_instance.dwh.password
  description = "The password for logging in to the dwh"
  sensitive   = true
}

output "dwh_address" {
  value       =  aws_db_instance.dwh.address
  description = "The endpoint of DWH"
}


