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
# DNS Module - CAA records
################################################################################

module "dns" {
  source = "../../"

  zone_name = "example.com"
  mode      = "primary"
  ttl       = 3600
  labels    = local.tags

  records = [
    # Allow Let's Encrypt
    { name = "@", type = "CAA", value = "0 issue \"letsencrypt.org\"" },

    # Allow wildcard issuance
    { name = "@", type = "CAA", value = "0 issuewild \"letsencrypt.org\"" },

    # Report violations (mailto)
    { name = "@", type = "CAA", value = "0 iodef \"mailto:security@example.com\"" },
  ]
}
