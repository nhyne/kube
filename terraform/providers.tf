provider "google" {
  credentials = file("~/.keys/nhyne.json")
  project     = "nhyne-233223"
  region      = "us-central1"

  version = "~> 2.11"
}

provider "null" {
  version = "~> 2.1"
}
