# Hetzner Cloud DNS Module

Terraform module for Hetzner DNS zones and records.

## Usage

```hcl
module "dns" {
  source  = "terraform-hc-modules/dns/hcloud"
  version = "~> 0.1"

  zone_name = "example.com"

  records = [
    { name = "@", type = "A", value = "1.2.3.4" },
    { name = "www", type = "CNAME", value = "example.com." },
  ]
}
```

## Submodules

| Module | Description |
|--------|-------------|
| [zone](modules/zone) | DNS zones |
| [records](modules/records) | DNS records |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.45 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_records"></a> [records](#module\_records) | ./modules/records | n/a |
| <a name="module_zone"></a> [zone](#module\_zone) | ./modules/zone | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create_zone"></a> [create\_zone](#input\_create\_zone) | Whether to create the zone. | `bool` | `true` | no |
| <a name="input_delete_protection"></a> [delete\_protection](#input\_delete\_protection) | Enable delete protection. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply. | `map(string)` | `{}` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | Mode of the zone (primary or secondary). | `string` | `"primary"` | no |
| <a name="input_records"></a> [records](#input\_records) | List of DNS records. | <pre>list(object({<br/>    name  = string<br/>    type  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Default TTL in seconds. | `number` | `3600` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Name of the zone (domain). | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_record_ids"></a> [record\_ids](#output\_record\_ids) | n/a |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | n/a |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | n/a |
<!-- END_TF_DOCS -->

## License

Mozilla Public License 2.0
