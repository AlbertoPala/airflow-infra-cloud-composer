# Workload Identity Federation Module
module "wif" {
  source = "../../modules/wif"

  project_id       = var.project_id
  project_number   = var.project_number
  gc_ci_sa         = var.gcp_ci_sa
  var_github_org   = var.var_github_org
  repo             = var.repo
  gcp_wif_provider = var.gcp_wif_provider
}
# Grant CI service account storage permissions for Terraform state via WIF
resource "google_project_iam_member" "ci_storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "principalSet://iam.googleapis.com/${var.gcp_wif_provider}/attribute.repository/${var.var_github_org}/${var.repo}"
}
# GCS Module - Terraform State Bucket
module "gcs_terraform_state" {
  source = "../../modules/gcs"

  name            = "tf-state-${var.project_id}-${var.env}"
  location        = var.region
  storage_class   = var.gcs_state_storage_class
  force_destroy   = false
  versioning      = true
}

# GCS Module - Data Lake Bucket
module "gcs_data_lake" {
  source = "../../modules/gcs"

  name            = "${var.project_id}-data-lake-${var.env}"
  location        = var.region
  storage_class   = var.gcs_data_lake_storage_class
  force_destroy   = var.gcs_data_lake_force_destroy
  versioning      = true
}

# GCS Module - Composer DAGs Bucket
module "gcs_dags" {
  source = "../../modules/gcs"

  name            = "${var.project_id}-dags-${var.env}"
  location        = var.region
  storage_class   = var.gcs_dags_storage_class
  force_destroy   = var.gcs_dags_force_destroy
  versioning      = true
}

# Cloud Composer Module
module "composer" {
  source = "../../modules/composer"

  project_id    = var.project_id
  region        = var.region
  env           = var.env
  name          = "airflow-${var.env}"
  composer_sa   = var.composer_service_account_email != "" ? var.composer_service_account_email : "composer@${var.project_id}.iam.gserviceaccount.com"

  depends_on = [
    module.gcs_dags
  ]
}

# Dataprocs Module
module "dataprocs" {
  source = "../../modules/dataprocs"

  project_id = var.project_id

  depends_on = [
    module.gcs_data_lake
  ]
}
