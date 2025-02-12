variable "credentials" {
  description = "My Credentials"
  default     = "/workspaces/data-engineering-zoomcamp/03-data-warehouse/terraform/keys/solid-acrobat-440004-g5-903ac2d18476.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "solid-acrobat-440004-g5"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "US-CENTRAL1"
}

# variable "bq_dataset_name" {
#   description = "My BigQuery Dataset Name"
#   #Update the below to what you want your dataset to be called
#   default     = "kestra_taxi_dataset"
# }

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "kestra_archive_bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}