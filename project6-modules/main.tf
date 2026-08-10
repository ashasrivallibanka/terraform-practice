terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

module "dev_file" {
  source = "./modules/file"

  filename = "dev.txt"
  content  = "Development Environment"
}
