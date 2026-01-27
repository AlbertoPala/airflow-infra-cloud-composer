resource "google_service_account_iam_binding" "github_wif" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.wif_provider}/attribute.repository/${var.var_github_org}/${var.repo}"
  ]
}
