resource "databricks_workspace_binding" "this" {
  lifecycle {
    precondition {
      condition     = coalesce(var.securable_type, "catalog") == "catalog" || coalesce(var.binding_type, "BINDING_TYPE_READ_WRITE") == "BINDING_TYPE_READ_WRITE"
      error_message = "Only a catalog can have a read-only workspace binding."
    }
  }

  workspace_id   = var.workspace_id
  securable_name = var.securable_name
  securable_type = var.securable_type
  binding_type   = var.binding_type
}
