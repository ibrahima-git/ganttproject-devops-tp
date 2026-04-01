variable "grafana_password" {
  description = "Mot de passe admin Grafana"
  type        = string
  default     = "admin123"
  sensitive   = true
}

variable "prometheus_port" {
  description = "Port externe Prometheus"
  type        = number
  default     = 9090
}

variable "grafana_port" {
  description = "Port externe Grafana"
  type        = number
  default     = 3000
}