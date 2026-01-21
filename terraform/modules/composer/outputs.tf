output "name" {
  description = "Nombre del environment"
  value       = google_composer_environment.this.name
}

output "airflow_uri" {
  description = "URL de Airflow"
  value       = google_composer_environment.this.config[0].airflow_uri
}
