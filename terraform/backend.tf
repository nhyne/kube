terraform {
  backend "gcs" {
    bucket      = "nhyne-terraform"
    prefix      = "state/nhyne"
    credentials = "~/.keys/nhyne.json"
  }

  required_version = "0.12.17"
}

