terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {
}

resource "local_file" "devops_file" {
  filename = "${path.module}/${var.filename}"
  content  = var.file_content
}

resource "local_file" "environment_file" {
  filename = "${path.module}/environment.txt"
  content  = "Environment: ${var.environment}"
}
