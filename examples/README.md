This example deploys an entire Aviatrix PoC environment, based on a provided yaml datamodel.


```hcl
module "poc" {
  source  = "terraform-aviatrix-modules/backbone/aviatrix"
  version = "v1.2.3"

  datamodel = file("datamodel.yaml")
}
```
