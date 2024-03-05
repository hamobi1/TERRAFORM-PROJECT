# environment variables 

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "region for project "
}


variable "project_name" {
  type        = string
  default     = "terra4m"
  description = "project name"
}


variable "environment" {
  type        = string
  default     = "development"
  description = "environment for terraform project"
}

# variables for vpc 

# variables for vpc 

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/24"
  description = "vpc cidr block"
}

variable "public_subnet_cidr" {
  type        = string
  default     = "10.0.0.0/25"
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  default     = "10.0.0.128/25"
  description = "CIDR block for the private subnet"
}

variable "tags" {
  type = map(string)
  default = {
    env        = "development"
    region     = "us-east-1"
    created_by = "murat"
  }
}