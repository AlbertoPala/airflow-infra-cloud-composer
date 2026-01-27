terraform {
  backend "gcs" {
    bucket = "tf-state-extraction-dev-484902"
    prefix = "infra"
  }
}
