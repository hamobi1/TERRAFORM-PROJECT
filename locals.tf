locals {
  env = "project"
  tags = {
    env        = "${local.env}"
    region     = "${local.region}"
    created_by = "murat"
  }
  region = "us-east-1"
}