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
# DNS Module - "RRset-like" multiple records (multiple A for same name)
################################################################################

module "dns" {
  source = "../../"

  zone_name = "example.com"
  mode      = "primary"
  ttl       = 60
  labels    = local.tags

  records = [
    { name = "@", type = "A", value = "1.2.3.4" },
    { name = "@", type = "A", value = "1.2.3.5" },
    { name = "@", type = "A", value = "1.2.3.6" },
  ]
}
