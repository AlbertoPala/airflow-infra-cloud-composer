terraform {
  backend "gcs" {
    bucket = "tf-state-extraction-dev"
    prefix = "infra"
  }
}
