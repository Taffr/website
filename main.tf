terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(".secrets/serviceAccountKey.json")
  project     = "simon-tenggren-website"
}

resource "google_artifact_registry_repository" "st-website-repo" {
  location      = "europe-west3"
  repository_id = "st-website-repository"
  description   = "Keep images here"
  format        = "DOCKER"
}

resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = true
}

resource "google_cloud_run_v2_service" "website" {
  name     = "website"
  location = "europe-west4"

  template {
    containers {
      image = "europe-west3-docker.pkg.dev/simon-tenggren-website/st-website-repository/site:latest"
      ports {
        container_port = 80
      }
    }
  }

  depends_on = [google_project_service.run_api]
}


resource "google_storage_bucket" "website_files" {
  name     = "st-website-files"
  location = "EU"

  cors {
    origin = ["*"]
    method = ["GET"]
  }
}

resource "google_storage_bucket_object" "blog_post_folder" {
  name    = "blog-posts/" # folder names should end with '/'
  content = " "           # content is ignored but required
  bucket  = google_storage_bucket.website_files.name
}

resource "google_storage_bucket_object" "first_blog_post" {
  name         = "${google_storage_bucket_object.blog_post_folder.name}first-post"
  source       = "./blogpost.json"
  bucket       = google_storage_bucket.website_files.name
  content_type = "application/json"
}

resource "google_storage_object_access_control" "public_rule" {
  bucket = google_storage_bucket.website_files.name
  object = google_storage_bucket_object.first_blog_post.name
  role   = "READER"
  entity = "allUsers"
}
