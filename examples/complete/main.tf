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
# DNS Module - Zone with Records
################################################################################

module "dns" {
  source = "../../"

  zone_name = "example.com"
  mode      = "primary"
  ttl       = 3600
  labels    = local.tags

  records = [
    { name = "@", type = "A", value = "1.2.3.4" },
    { name = "www", type = "CNAME", value = "example.com." },
    { name = "mail", type = "MX", value = "10 mail.example.com." },
  ]
}
