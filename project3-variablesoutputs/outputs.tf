output "server_count" {
  value = var.server_count
}

output "monitoring_enabled" {
  value = var.enable_monitoring
}

output "first_server" {
  value = var.servers[0]
}

output "dev_instance_type" {
  value = var.instance_types["dev"]
}

output "environment" {
  value = var.environment
}
