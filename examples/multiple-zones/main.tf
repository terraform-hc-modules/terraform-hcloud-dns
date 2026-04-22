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
# Multiple zones (two module instances)
################################################################################

module "dns_primary" {
  source = "../../"

  zone_name = "example.com"
  ttl       = 3600
  mode      = "primary"
  labels    = local.tags

  records = [
    { name = "@", type = "A", value = "1.2.3.4" },
    { name = "www", type = "CNAME", value = "example.com." },
  ]
}

module "dns_secondary" {
  source = "../../"

  zone_name = "example.net"
  ttl       = 3600
  mode      = "primary"
  labels    = local.tags

  records = [
    { name = "@", type = "A", value = "5.6.7.8" },
    { name = "api", type = "A", value = "5.6.7.9" },
  ]
}
