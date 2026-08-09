terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

resource "local_file" "state_demo" {
  filename = "${path.module}/state-demo.txt"
  content  = "Terraform State Updated"
}
