resource "google_service_account_iam_member" "github_wif" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.gcp_ci_sa}"
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${var.gcp_wif_pool}/attribute.repository/${var.var_github_org}/${var.repo}"
}

resource "google_service_account_iam_member" "github_token_creator" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.gcp_ci_sa}"
  role               = "roles/iam.serviceAccountTokenCreator"

  member = "principalSet://iam.googleapis.com/${var.gcp_wif_pool}/attribute.repository/${var.var_github_org}/${var.repo}"
}
