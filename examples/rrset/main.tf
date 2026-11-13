provider "hcloud" {}

locals {
  name = "ex-${basename(path.cwd)}"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-hcloud-dns"
    GithubOrg  = "terraform-hc-modules"
  }
}

################################################################################
# DNS Module - RRSets (one resource per name and type)
################################################################################

module "dns" {
  source = "../../"

  zone_name = "example.com"
  mode      = "primary"
  ttl       = 3600
  labels    = local.tags

  rrsets = [
    {
      name   = "@"
      type   = "A"
      ttl    = 300
      labels = local.tags
      records = [
        { value = "203.0.113.10", comment = "web 1" },
        { value = "203.0.113.11", comment = "web 2" },
      ]
    },
    {
      name = "@"
      type = "MX"
      records = [
        { value = "10 mail1.example.com." },
        { value = "20 mail2.example.com." },
      ]
    },
    {
      name              = "www"
      type              = "CNAME"
      change_protection = true
      records = [
        { value = "example.com." },
      ]
    },
  ]
}
