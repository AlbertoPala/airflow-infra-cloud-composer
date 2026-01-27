resource "google_service_account_iam_binding" "github_wif" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.gcp_ci_sa}"
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.gcp_wif_provider}/attribute.repository/${var.var_github_org}/${var.repo}"
  ]
}

resource "google_service_account_iam_binding" "github_token_creator" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.gcp_ci_sa}"
  role               = "roles/iam.serviceAccountTokenCreator"

  members = [
    "principalSet://iam.googleapis.com/${var.gcp_wif_provider}/attribute.repository/${var.var_github_org}/${var.repo}"
  ]
}
