module "poc" {
  source  = "terraform-aviatrix-modules/poc/aviatrix"
  version = "v1.0.2"

  datamodel = file("datamodel.yaml")
}
