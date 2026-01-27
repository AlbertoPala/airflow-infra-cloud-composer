variable "project_id" {
  description = "GCP Project ID - from GCP_PROJECT_ID secret"
  type        = string
}

variable "project_number" {
  description = "GCP Project Number - from PROJECT_NUMBER secret"
  type        = string
}

variable "env" {
  description = "Environment name - from ENV variable"
  type        = string
}

variable "gcp_ci_sa" {
  description = "CI/CD Service account email - from GCP_CI_SA secret"
  type        = string
}

variable "var_github_org" {
  description = "GitHub organization - from VAR_GITHUB_ORG secret"
  type        = string
}

variable "repo" {
  description = "GitHub repository name - from REPO secret"
  type        = string
}

variable "gcp_wif_provider" {
  description = "Full resource name of the WIF provider - from GCP_WIF_PROVIDER secret"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "composer_service_account_email" {
  description = "Service account email for Cloud Composer (auto-generated from project_id)"
  type        = string
  default     = ""
}

variable "gcs_data_lake_storage_class" {
  description = "Storage class for data lake bucket"
  type        = string
  default     = "STANDARD"
}

variable "gcs_dags_storage_class" {
  description = "Storage class for DAGs bucket"
  type        = string
  default     = "STANDARD"
}

variable "gcs_state_storage_class" {
  description = "Storage class for Terraform state bucket"
  type        = string
  default     = "STANDARD"
}

variable "gcs_data_lake_force_destroy" {
  description = "Allow destroying data lake bucket with contents"
  type        = bool
  default     = false
}

variable "gcs_dags_force_destroy" {
  description = "Allow destroying DAGs bucket with contents"
  type        = bool
  default     = false
}
