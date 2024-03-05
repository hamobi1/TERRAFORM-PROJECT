variable "ami" {
  type        = string
  default     = "ami-0440d3b780d96b29d"
  description = "ami id for amazon linux"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "default ec2 size"
}  

variable "public_subnet_id" {
  type = string
  description = "public subent id"
}

variable "private_subnet_id" {
  type = string
  description = "public subent id"
}

variable "ssh_public_key" {
  type    = string
  description = "ssh public key"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIBOHyeJ2/9vb34gYkDDSyxG7R4OP1G6ROFHzX1Dm8cpHTZ9AaZPtroUVkn0z4vs1+Kreb22Fwb6KCk2/Hdv1qeMjFnfoxv9uhn1h8+XJrC3ywTl+iprT3UFktvtwyuybEIPopWYeUEtzlELR3fFd49KECNdzuvvExtuGRtKPD5rRalMLvrHdX7liWTN21q5etM7TUmKCucJ2OBH7oz0UM5PH5z+2DUy45qyFrt/DnCTXxOD8+lgYpLpZpGgbgqNkFzt+9L2z2dDweN++Ec58VRweGEj0b/W5QbH40ALYMb2YTL6Z2XYEWzNMHdpszGAjH4Wv2SQ7VxlWFjKp0a26UGDVAK4M6jrUlg2tTjWTsydntaoTQQY1XiVE90vV7Na0ExtcqGYg6eOHUXccyp/+1ucC2TEMM5Y/bAU/WqwdQS7/cQoO+fs0ktCMD7YocDMFEjNY8YmWrwP/dd3OMQqkZSZIPMwzux/ptTB2kn29I+tdF4S3Lj5aSV04Etor65h8= muratnesiren14@Murats-MacBook-Air.local"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

