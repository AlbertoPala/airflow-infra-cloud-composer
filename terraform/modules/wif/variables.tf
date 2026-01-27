variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "project_number" {
  description = "GCP project number"
  type        = string
}

variable "service_account_email" {
  description = "Service account impersonated by GitHub"
  type        = string
}

variable "var_github_org" {
  description = "GitHub organization or user"
  type        = string
}

variable "repo" {
  description = "GitHub repository name"
  type        = string
}

variable "wif_provider" {
  description = "Full resource name of the WIF provider (GCP_WIF_PROVIDER secret)"
  type        = string
}
