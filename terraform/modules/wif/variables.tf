variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "project_number" {
  description = "GCP project number"
  type        = string
}

variable "gcp_ci_sa" {
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

variable "gcp_wif_provider" {
  description = "Full resource name of the WIF provider (GCP_WIF_PROVIDER secret)"
  type        = string
}

variable "gcp_wif_pool" {
  description = "WIF pool resource name (format: projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID)"
  type        = string
}
