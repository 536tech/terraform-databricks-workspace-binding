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

run "reject_blank_name" {
  command = plan
  variables {
    securable_name = "  "
  }
  expect_failures = [var.securable_name]
}

run "reject_read_only_storage" {
  command = plan
  variables {
    securable_type = "storage_credential"
    binding_type   = "BINDING_TYPE_READ_ONLY"
  }
  expect_failures = [databricks_workspace_binding.this]
}

run "reject_fractional_id" {
  command = plan
  variables {
    workspace_id = 1.5
  }
  expect_failures = [var.workspace_id]
}
