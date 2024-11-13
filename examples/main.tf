module "poc" {
  source  = "terraform-aviatrix-modules/poc/aviatrix"
  version = "v1.1.0"

  datamodel = yamldecode(file("datamodel.yaml"))
}
