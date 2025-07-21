locals {
  metadata = {
    region      = "us-east-2"
    environment = "laboratory"
    project     = "example"
  }

  key = {
    company = "exp" # short name
    region  = "use2"
    env     = "lab" # env
    project = "pct" # project
  }

  common_name = join("-", [
    local.metadata.project,
    local.metadata.environment
  ])

  common_tags = {
    "company"     = local.metadata.key.company
    "provisioner" = "terraform"
    "environment" = local.metadata.environment
    "project"     = local.metadata.project
    "created-by"  = "GoCloud.la"
  }
}
