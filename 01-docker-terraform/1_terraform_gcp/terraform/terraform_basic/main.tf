terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.19.0"
    }
  }
}

provider "google" {
  project = "dezoomcamp-416702"
  region  = "us-central1"
}

resource "google_storage_bucket" "demo_bucket" {
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

resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = "terra_dataset"
}