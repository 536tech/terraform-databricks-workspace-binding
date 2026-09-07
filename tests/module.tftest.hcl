mock_provider "databricks" {}

variables {

  workspace_id   = 123456789
  securable_name = "sales"
  securable_type = "catalog"
  binding_type   = "BINDING_TYPE_READ_WRITE"
}

run "documented_example" {
  command = apply

  assert {
    condition     = databricks_workspace_binding.this.securable_name == var.securable_name
    error_message = "The resource must preserve its configured name."
  }
}
