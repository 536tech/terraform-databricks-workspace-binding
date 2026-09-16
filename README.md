# Databricks workspace binding Terraform module

One workspace binding for a catalog, external location, or storage credential.
The securable must use isolated access. Only catalogs support read-only bindings.
The import ID is `<workspace_id>|<securable_type>|<securable_name>`.
Keep the binding in the same state as its securable.

See the [Databricks provider documentation](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/workspace_binding).

## Usage

```hcl
module "workspace_binding" {
  source  = "536tech/workspace-binding/databricks"
  version = "1.0.0"

  workspace_id   = 123456789
  securable_name = "sales"
  securable_type = "catalog"
  binding_type   = "BINDING_TYPE_READ_WRITE"
}
```

## Compatibility

Configure the Databricks provider in the calling root with a workspace endpoint.
This resource module is also used by the
[workspace pattern module](https://registry.terraform.io/modules/536tech/workspace/databricks/latest).
Each repository has its own releases. Consumers select an exact tested module version.

The resource addresses match the original workspace submodule in version 0.1.1.
To migrate a direct submodule call, change its source and version. Keep the module block name.
Run `terraform init` and require a plan with no resource changes.
DataTF exports continue to use the workspace pattern module and its existing import addresses.

## Development

Use Terraform 1.7 or later for the mock tests. The module supports Terraform 1.5 or later.

```sh
prek install
terraform init -backend=false -lockfile=readonly
terraform validate
terraform test
tflint --recursive
prek run --all-files
```

CI tests the committed provider version and the minimum supported provider, 1.128.0.
The workspace pattern module checks the complete DataTF contract and its integration behavior.

## License

[Apache-2.0](LICENSE).

## Input safeguards

The module rejects blank required names and invalid access inputs during the plan.
Cross-input preconditions preserve the Terraform 1.5 minimum and existing resource addresses.
The standalone module also accepts service credential bindings (`securable_type = "credential"`).
DataTF exports only its documented catalog, storage credential, and external location bindings.
Null remains valid for inputs where the provider supplies a default.
Provider and API checks still apply. These checks do not prove complete permission visibility.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- terraform (>= 1.5.0)

- databricks (>= 1.128.0, < 2.0.0)

## Providers

The following providers are used by this module:

- databricks (>= 1.128.0, < 2.0.0)

## Resources

The following resources are used by this module:

- [databricks_workspace_binding.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/workspace_binding) (resource)

## Required Inputs

The following input variables are required:

### binding\_type

Description: Read-only or read-write binding type.

Type: `string`

### securable\_name

Description: Unity Catalog securable name.

Type: `string`

### securable\_type

Description: Unity Catalog securable type.

Type: `string`

### workspace\_id

Description: Workspace ID to bind.

Type: `number`

## Outputs

The following outputs are exported:

### id

Description: Workspace binding ID.
<!-- END_TF_DOCS -->