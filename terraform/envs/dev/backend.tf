terraform {
  backend "gcs" {
    bucket = "tf-state-myproject-dev"
    prefix = "infra"
  }
}
