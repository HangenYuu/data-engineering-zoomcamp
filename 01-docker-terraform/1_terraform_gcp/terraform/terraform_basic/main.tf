terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.19.0"
    }
  }
}

provider "google" {
  project     = "dezoomcamp-416702"
  region      = "us-central1"
}

resource "google_storage_bucket" "auto-expire" {
  name          = "dezoomcamp-416702-terra-bucket"
  location      = "US"
  force_destroy = true
  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}