# create vpc
resource "aws_vpc" "project_vpc" {
  cidr_block = "10.0.0.0/24" 

  tags = var.tags
}

# create public subnet 
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "${var.region}a"

  tags = var.tags
}

# create private app subnet b
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.region}b"

  tags = var.tags
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.project_vpc.id 

  tags = var.tags
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = var.tags
}

# Define Elastic IP for NAT gateway
resource "aws_eip" "nat_gateway" {
  domain = "vpc"
}

# create nat gateway attach to public subnet 
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = var.tags

  depends_on = [aws_internet_gateway.internet_gateway]
}

# create route table for NAT gateway
resource "aws_route_table" "rt_for_nat" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = var.tags

}

# associate private subnet with NAT gateway route table
resource "aws_route_table_association" "nat_rt_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rt_for_nat.id
}

 #network acl (NACL)rules for project vpc
resource "aws_network_acl" "project" {
  vpc_id = aws_vpc.project_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = var.tags
}

