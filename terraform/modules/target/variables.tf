######################################
# Module: target
######################################

######################################
# vpc.tf
######################################

#-------------------------------------
# VPC
#-------------------------------------

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "vpc_name" {
  description = "VPC name (Tag)"
  type        = string
  default     = "target_vpc"
}

#-------------------------------------
# Subnet
#-------------------------------------

variable "vpc_public_subnet_count" {
  description = "count of public subnet"
  type        = number
  default     = 3
}

variable "vpc_private_subnet_count" {
  description = "count of private subnet"
  type        = number
  default     = 3
}

variable "vpc_subnet_az" {
  description = "Subnet Availavility Zone list"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "vpc_subnet_public_names" {
  description = "Public Subnet name list"
  type        = list(string)
  default     = ["target-public-1a", "target-public-1c", "target-public-1d"]
}

variable "vpc_subnet_private_names" {
  description = "Private Subnet name list"
  type        = list(string)
  default     = ["target-private-1a", "target-private-1c", "target-private-1d"]
}

#-------------------------------------
# Internet Gateway
#-------------------------------------

variable "vpc_igw_name" {
  description = "Internet Gateway name (Tag)"
  type        = string
  default     = "target_internet_gateway"
}

#-------------------------------------
# VPC Endpoint (S3 Gateway)
#-------------------------------------

variable "vpc_endpoint_service_name_s3" {
  description = "S3 service name"
  type        = string
  default     = "com.amazonaws.ap-northeast-1.s3"
}

variable "vpc_endpoint_name_s3" {
  description = "VPC Endpoint name for S3 Gateway (Tag)"
  type        = string
  default     = "target_vpc_endpoint_s3"
}

#-------------------------------------
# Route Table
#-------------------------------------

variable "vpc_route_table_public_name" {
  description = "Name of Route Table for Public (Tag)"
  type        = string
  default     = "target_public_route_table"
}

variable "vpc_route_table_private_name_list" {
  description = "List of Name of Route Table for Public (Tag)"
  type        = list(string)
  default     = ["target_private_route_table_01", "target_private_route_table_02", "target_private_route_table_03"]
}


######################################
# rds.tf
######################################

#-------------------------------------
# Rds Instance
#-------------------------------------

variable "rds_instance_storage_size" {
  description = "RDS instance's allocated storage size"
  type        = number
  default     = "20"
}

variable "rds_instance_engine" {
  description = "RDS instance's engine"
  type        = string
  default     = "postgres"
}

variable "rds_instance_engine_version" {
  description = "RDS instance's engine version"
  type        = string
  default     = "13.6"
}

variable "rds_instance_class" {
  description = "RDS instance's instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_instance_username" {
  description = "RDS instance's master user's name"
  type        = string
  default     = "postgres"
}

variable "rds_instance_id" {
  description = "RDS instance's identifier"
  type        = string
  default     = "dbt-ecs-tutorial"
}

#-------------------------------------
# Parameter Group
#-------------------------------------

variable "rds_parameter_group_name" {
  description = "RDS Paremeter Group name"
  type        = string
  default     = "postgres-13-dwh"
}

variable "rds_parameter_group_family" {
  description = "RDS Paremeter Group family"
  type        = string
  default     = "postgres13"
}

#-------------------------------------
# Subnet Group
#-------------------------------------

variable "rds_subnet_group_name" {
  description = "RDS Subnet Group name"
  type        = string
  default     = "subnet-group-dwh"
}

variable "rds_subnet_group_subnet_ids" {
  description = "List of RDS Subnet Group's subnet id"
  type        = list(string)
  default     = []
}

variable "rds_instance_security_group_ids" {
  description = "RDS Subnet Group name"
  type        = list(string)
  default     = []
}



######################################
# security_group.tf
######################################

#-----------------------------------------
# Security Group
#-----------------------------------------

variable "rds_instance_security_group_name" {
  description = "RDS Security Group Name"
  type = string
  default = "dbt-ecs-tutorial-dwh-sg"
}

variable "rds_instance_sg_ingress_001_from_port" {
  description = "RDS Security Group from port"
  type = number
  default = 5432
}

variable "rds_instance_sg_ingress_001_to_port" {
  description = "RDS Security Group to port"
  type = number
  default = 5432
}

variable "rds_instance_sg_ingress_001_protocol" {
  description = "RDS Security Group protocol"
  type = string
  default = "tcp"
}

variable "dbt_container_security_group_name" {
  description = "dbt Container Security Group Name"
  type = string
  default = "dbt-ecs-tutorial-dbt-sg"
}



######################################
# parameters.tf
######################################

#-----------------------------------------
# SSM Parameter Store
#-----------------------------------------

variable "paramter_store_name_rds_instance_password" {
  description = "parameter name of RDS mastasr user password"
  type = string
  default = "/dbt-ecs-tutorial/rds/dwh/password/master"
}

variable "paramter_store_name_rds_instance_address" {
  description = "parameter name of RDS address"
  type = string
  default = "/dbt-ecs-tutorial/rds/dwh/address"
}



