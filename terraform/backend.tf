terraform {
  backend "gcs" {
    bucket = "nhyne-terraform"
    prefix = "state/nhyne"
  }
}
