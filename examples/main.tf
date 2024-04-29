module "poc" {
  source  = "terraform-aviatrix-modules/poc/aviatrix"
  version = "v1.0.1"

  datamodel = file("datamodel.yaml")
}
