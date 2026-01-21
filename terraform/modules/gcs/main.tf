resource "google_storage_bucket" "this" {
  name          = var.name
  location      = var.location
  storage_class = var.storage_class
  force_destroy = var.force_destroy

  versioning {
    enabled = var.versioning
  }

  uniform_bucket_level_access = true
}
