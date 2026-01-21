variable "name" {
  description = "Nombre del bucket"
  type        = string
}

variable "location" {
  description = "Región o ubicación del bucket"
  type        = string
}

variable "storage_class" {
  description = "Clase de almacenamiento"
  type        = string
  default     = "STANDARD"
}

variable "versioning" {
  description = "Habilitar versionado de objetos"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Permitir borrar bucket con contenido"
  type        = bool
  default     = false
}
