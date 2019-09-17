provider "google" {
  credentials = file("~/.keys/nhyne.json")
  project     = "nhyne-233223"
  region      = "us-central1"

  version = "~> 2.15"
}

provider "null" {
  version = "~> 2.1"
}

provider "kubernetes" {
  # config_context_cluster   = ""
  version = "~> 1.9.0"
}

provider "random" {
  version = "~> 2.2.0"
}
