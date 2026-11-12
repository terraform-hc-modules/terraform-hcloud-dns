# RRSet

Manages Hetzner DNS RRSets (all records sharing a name and type) within a zone.

Part of [`terraform-hc-modules/dns/hcloud`](../../README.md). Prefer the root module for most use cases; use this submodule directly when you need fine-grained control over just RRSet resources.

## Usage

```hcl
module "rrset" {
  source = "terraform-hc-modules/dns/hcloud//modules/rrset"
  # version = "~> 0.1"

  # See inputs below.
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.60 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | >= 1.60 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [hcloud_zone_rrset.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/zone_rrset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone ID or name. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the RRSets. | `bool` | `true` | no |
| <a name="input_rrsets"></a> [rrsets](#input\_rrsets) | List of DNS RRSets. Each name and type pair must be unique, all values for that pair go in 'records'. | <pre>list(object({<br/>    name              = string<br/>    type              = string<br/>    ttl               = optional(number)<br/>    labels            = optional(map(string))<br/>    change_protection = optional(bool)<br/>    records = list(object({<br/>      value   = string<br/>      comment = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_rrset_ids"></a> [rrset\_ids](#output\_rrset\_ids) | Map of RRSet IDs, keyed as '<TYPE>-<NAME>'. |
<!-- END_TF_DOCS -->
