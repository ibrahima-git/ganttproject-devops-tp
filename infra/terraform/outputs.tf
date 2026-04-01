output "prometheus_url" {
  description = "URL Prometheus"
  value       = "http://localhost:${var.prometheus_port}"
}

output "grafana_url" {
  description = "URL Grafana"
  value       = "http://localhost:${var.grafana_port}"
}

output "jaeger_url" {
  description = "URL Jaeger UI"
  value       = "http://localhost:16686"
}