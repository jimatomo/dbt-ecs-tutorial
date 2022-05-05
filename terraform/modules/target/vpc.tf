#-----------------------------------------
# VPC
#-----------------------------------------

resource "aws_vpc" "target_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

#-----------------------------------------
# Subnet
#-----------------------------------------

resource "aws_subnet" "target_public_subnet" {
  count             = var.vpc_public_subnet_count
  vpc_id            = aws_vpc.target_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.target_vpc.cidr_block, 8, count.index)
  availability_zone = var.vpc_subnet_az[count.index]

  tags = {
    Name = var.vpc_subnet_public_names[count.index]
  }
}

resource "aws_subnet" "target_private_subnet" {
  count             = var.vpc_private_subnet_count
  vpc_id            = aws_vpc.target_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.target_vpc.cidr_block, 8, count.index + length(aws_subnet.target_public_subnet))
  availability_zone = var.vpc_subnet_az[count.index]

  tags = {
    Name = var.vpc_subnet_private_names[count.index]
  }
}

#-----------------------------------------
# Route table
#-----------------------------------------

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.target_vpc.id

  tags = {
    Name = var.vpc_route_table_public_name
  }
}

resource "aws_route_table" "private_route_table" {
  count  = var.vpc_private_subnet_count
  
  vpc_id = aws_vpc.target_vpc.id

  tags = {
    Name = var.vpc_route_table_private_name_list[count.index]
  }
}

#-----------------------------------------
# Route table association
#-----------------------------------------

resource "aws_route_table_association" "route_table_association_public" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.target_public_subnet.id
}

resource "aws_route_table_association" "route_table_association_private" {
  count = var.vpc_private_subnet_count

  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = aws_subnet.target_private_subnet[count.index].id
}

#-----------------------------------------
# Internet Gateway
#-----------------------------------------

resource "aws_internet_gateway" "target_igw" {
  vpc_id = aws_vpc.target_vpc.id

  tags = {
    Name = var.vpc_igw_name
  }
}

# IGW route for Public
resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.public_route_table
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.target_igw.id
}

#-----------------------------------------
# VPC Endpoint (S3 Gateway)
#-----------------------------------------

resource "aws_vpc_endpoint" "gateway_endpoint_s3" {
  vpc_id       = aws_vpc.target_vpc.id
  service_name = var.vpc_endpoint_service_name_s3

  tags = {
    Name = var.vpc_endpoint_name_s3
  }
}

# VPC Endpoint route (public)
resource "aws_vpc_endpoint_route_table_association" "route_to_gateway_s3_public" {
  route_table_id  = aws_vpc.target_vpc.id
  vpc_endpoint_id = aws_vpc_endpoint.gateway_endpoint_s3.id
}

# VPC Endpoint route (private)
resource "aws_vpc_endpoint_route_table_association" "route_to_gateway_s3_private" {
  count           = var.vpc_private_subnet_count

  #route_table_id  = target_private_route_table_id_list[count.index]
  route_table_id  = aws_route_table.private_route_table[count.index].id
  vpc_endpoint_id = aws_vpc_endpoint.gateway_endpoint_s3.id
}
