resource "google_composer_environment" "this" {
  name    = var.name
  project = var.project_id
  region  = var.region

  config {

    environment_size = "ENVIRONMENT_SIZE_SMALL"

    software_config {
      image_version = "composer-3-airflow-2.9.3"

      env_variables = {
        AIRFLOW__CORE__LOAD_EXAMPLES = "False"
      }
    }

    node_config {
      service_account = var.composer_sa
    }
  }
}
