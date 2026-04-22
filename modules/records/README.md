# Records

Manages Hetzner DNS records within a zone.

Part of [`terraform-hc-modules/dns/hcloud`](../../README.md). Prefer the root module for most use cases; use this submodule directly when you need fine-grained control over just records resources.

## Usage

```hcl
module "records" {
  source = "terraform-hc-modules/dns/hcloud//modules/records"
  # version = "~> 0.1"

  # See inputs below.
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.45 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | >= 1.45 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [hcloud_zone_record.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/zone_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the records. | `bool` | `true` | no |
| <a name="input_records"></a> [records](#input\_records) | List of DNS records. | <pre>list(object({<br/>    name  = string<br/>    type  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone ID or name. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_record_ids"></a> [record\_ids](#output\_record\_ids) | Map of record IDs, keyed by a stable unique key. |
| <a name="output_record_ids_by_type_name"></a> [record\_ids\_by\_type\_name](#output\_record\_ids\_by\_type\_name) | Map of record IDs grouped by record type and name, keyed as '<TYPE>-<NAME>'. |
<!-- END_TF_DOCS -->
