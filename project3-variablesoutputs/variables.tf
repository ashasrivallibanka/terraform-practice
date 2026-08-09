variable "filename" {
  description = "Name of the file to create"
  type        = string
}

variable "file_content" {
  description = "Content to store inside the file"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "server_count" {
  description = "Number of servers"
  type        = number
  default     = 2
}

variable "enable_monitoring" {
  description = "Whether monitoring is enabled"
  type        = bool
  default     = true
}

variable "servers" {
  description = "List of server names"
  type        = list(string)
  default     = ["server1", "server2"]
}

variable "instance_types" {
  description = "Instance types for each environment"
  type        = map(string)

  default = {
    dev  = "t3.micro"
    test = "t3.small"
    prod = "t3.large"
  }
}
