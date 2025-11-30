variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "location" {
  description = "The GCP location for the resources."
  type        = string
}

variable "frontend_service_name" {
  description = "The name of the frontend Cloud Run service."
  type        = string
  default     = "genai-frontend"
}

variable "backend_service_name" {
  description = "The name of the backend Cloud Run service."
  type        = string
  default     = "genai-backend"
}

variable "frontend_image_name" {
  description = "The Docker image for the frontend."
  type        = string
}

variable "backend_image_name" {
  description = "The Docker image for the backend."
  type        = string
}

variable "bucket_name" {
  description = "The name of the storage bucket."
  type        = string
  default     = "genai-story-images"
}
