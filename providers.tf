terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.5.0"
    }
  }
}

provider "google" {
  credentials = file("lab-6-489108-fd282f304671.json")

  project = var.gcp-project
  region  = "europe-west1"
  zone    = "europe-west1-b"
}
