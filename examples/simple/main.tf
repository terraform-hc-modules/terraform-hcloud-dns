provider "hcloud" {}

module "zone" {
  source = "../../modules/zone"

  name = "example.com"
}
