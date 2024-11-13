This example deploys an entire Aviatrix PoC environment, based on a provided yaml datamodel.


```hcl
module "poc" {
  source  = "terraform-aviatrix-modules/poc/aviatrix"
  version = "v1.1.0"

  datamodel = yamldecode(file("datamodel.yaml"))
}
```
