terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "simon-tenggren-website"
  region  = "europe-north1"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "cr-simon-tenggren-website"
  location = "europe-north1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "europe-north1-docker.pkg.dev/simon-tenggren-website/website-repo/simon-tenggren-website:2025-10-26-21-29"
      ports {
        container_port = 80
      }
    }
  }
}

resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloud_run_v2_service.default.location
  service  = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}

resource "google_artifact_registry_repository" "website-repo" {
  location      = "europe-north1"
  repository_id = "website-repo"
  description   = "Docker repo for images relating to the website"
  format        = "DOCKER"
}
