variable "name" {
  description = "Nombre del environment de Cloud Composer"
  type        = string
}

variable "project_id" {
  description = "Project ID de GCP"
  type        = string
}

variable "region" {
  description = "Región del environment"
  type        = string
}

variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "composer_sa" {
  description = "Service Account que usará Cloud Composer"
  type        = string
}
