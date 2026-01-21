resource "google_project_service" "dataproc" {
  project = var.project_id
  service = "dataproc.googleapis.com"

  disable_on_destroy = false
}
