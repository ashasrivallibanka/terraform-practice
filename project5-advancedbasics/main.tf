locals {
  project_name = "taskmanager"
  environment  = "dev"

  name_prefix = "${local.project_name}-${local.environment}"
}

resource "local_file" "example" {
  filename = "${local.name_prefix}.txt"
  content  = "Created using Terraform locals"
}
