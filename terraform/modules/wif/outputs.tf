output "service_account_iam_binding" {
  description = "IAM binding for GitHub WIF service account"
  value       = google_service_account_iam_binding.github_wif.role
}
