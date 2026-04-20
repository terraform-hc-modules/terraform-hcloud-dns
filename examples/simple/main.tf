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
# DNS Zone
################################################################################

module "zone" {
  source = "../../modules/zone"

  name   = "example.com"
  mode   = "primary"
  ttl    = 3600
  labels = local.tags
}
