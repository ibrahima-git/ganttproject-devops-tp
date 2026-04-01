terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Réseau Docker
resource "docker_network" "gantt_network" {
  name = "gantt-network-tf"
}

# Volume Grafana
resource "docker_volume" "grafana_data" {
  name = "grafana-data-tf"
}

# Image Prometheus
resource "docker_image" "prometheus" {
  name         = "prom/prometheus:latest"
  keep_locally = true
}

# Image Grafana
resource "docker_image" "grafana" {
  name         = "grafana/grafana:latest"
  keep_locally = true
}

# Image Loki
resource "docker_image" "loki" {
  name         = "grafana/loki:latest"
  keep_locally = true
}

# Image Jaeger
resource "docker_image" "jaeger" {
  name         = "jaegertracing/all-in-one:latest"
  keep_locally = true
}

# Conteneur Prometheus
resource "docker_container" "prometheus" {
  name  = "prometheus-tf"
  image = docker_image.prometheus.image_id

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    host_path      = abspath("../../observability/prometheus/prometheus.yml")
    container_path = "/etc/prometheus/prometheus.yml"
  }

  networks_advanced {
    name = docker_network.gantt_network.name
  }

  restart = "unless-stopped"
}

# Conteneur Grafana
resource "docker_container" "grafana" {
  name  = "grafana-tf"
  image = docker_image.grafana.image_id

  ports {
    internal = 3000
    external = 3000
  }

  env = [
    "GF_SECURITY_ADMIN_PASSWORD=admin123"
  ]

  volumes {
    volume_name    = docker_volume.grafana_data.name
    container_path = "/var/lib/grafana"
  }

  networks_advanced {
    name = docker_network.gantt_network.name
  }

  restart = "unless-stopped"
}

# Conteneur Loki
resource "docker_container" "loki" {
  name  = "loki-tf"
  image = docker_image.loki.image_id

  ports {
    internal = 3100
    external = 3100
  }

  networks_advanced {
    name = docker_network.gantt_network.name
  }

  restart = "unless-stopped"
}

# Conteneur Jaeger
resource "docker_container" "jaeger" {
  name  = "jaeger-tf"
  image = docker_image.jaeger.image_id

  ports {
    internal = 16686
    external = 16686
  }

  networks_advanced {
    name = docker_network.gantt_network.name
  }

  restart = "unless-stopped"
}