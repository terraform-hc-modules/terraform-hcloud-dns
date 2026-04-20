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
<!-- END_TF_DOCS -->

## License

Mozilla Public License 2.0
