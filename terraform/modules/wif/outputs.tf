output "service_account_iam_member" {
  description = "IAM member for GitHub WIF service account"
  value       = google_service_account_iam_member.github_wif.role
}
