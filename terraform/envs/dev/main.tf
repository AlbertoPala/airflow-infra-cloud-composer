# Workload Identity Federation Module
module "wif" {
  source = "../../modules/wif"

  project_id          = var.project_id
  project_number      = var.project_number
  service_account_email = var.ci_service_account_email
  var_github_org        = var.var_github_org
  repo                  = var.repo
  wif_provider          = var.wif_provider
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
