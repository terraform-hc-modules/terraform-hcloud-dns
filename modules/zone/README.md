# Zone

Manages Hetzner DNS zones.

Part of [`terraform-hc-modules/dns/hcloud`](../../README.md). Prefer the root module for most use cases; use this submodule directly when you need fine-grained control over just zone resources.

## Usage

```hcl
module "zone" {
  source = "terraform-hc-modules/dns/hcloud//modules/zone"
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
| [hcloud_zone.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the zone. | `bool` | `true` | no |
| <a name="input_delete_protection"></a> [delete\_protection](#input\_delete\_protection) | Enable delete protection. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply. | `map(string)` | `{}` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | Mode of the zone (primary or secondary). | `string` | `"primary"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the zone (domain). | `string` | n/a | yes |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Default TTL in seconds. | `number` | `3600` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_authoritative_nameservers"></a> [authoritative\_nameservers](#output\_authoritative\_nameservers) | Authoritative nameservers. |
| <a name="output_id"></a> [id](#output\_id) | ID of the zone. |
| <a name="output_name"></a> [name](#output\_name) | Name of the zone. |
<!-- END_TF_DOCS -->
