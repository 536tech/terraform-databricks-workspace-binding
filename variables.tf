variable "workspace_id" {
  description = "Workspace ID to bind."
  type        = number
  nullable    = false

  validation {
    condition     = try(var.workspace_id > 0 && floor(var.workspace_id) == var.workspace_id, false)
    error_message = "workspace_id must be a positive integer."
  }
}

variable "securable_name" {
  description = "Unity Catalog securable name."
  type        = string
  nullable    = false

  validation {
    condition     = try(length(trimspace(var.securable_name)) > 0, false)
    error_message = "securable_name must not be empty or blank."
  }
}

variable "securable_type" {
  description = "Unity Catalog securable type."
  type        = string

  validation {
    condition     = var.securable_type == null ? true : contains(["catalog", "storage_credential", "external_location", "credential"], var.securable_type)
    error_message = "securable_type must be catalog, storage_credential, external_location, or credential."
  }
}

variable "binding_type" {
  description = "Read-only or read-write binding type."
  type        = string

  validation {
    condition     = var.binding_type == null ? true : contains(["BINDING_TYPE_READ_ONLY", "BINDING_TYPE_READ_WRITE"], var.binding_type)
    error_message = "binding_type must be BINDING_TYPE_READ_ONLY or BINDING_TYPE_READ_WRITE."
  }
}
