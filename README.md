# Terraform Aviatrix PoC

> [!CAUTION]
> Do not use this module in production environments.

### Description

This module provides a simplified way to deploy a PoC environment, by taking a YAML datamodel and deploying all resources, without the need to write actual Terraform code.

### Compatibility

| Module version | Terraform version | Controller version | Terraform provider version |
| :------------- | :---------------- | :----------------- | :------------------------- |
| v1.0.1         | >= 1.4.0          | 7.1                | ~> 3.1.0                   |

### Assumptions

- You already have an Aviatrix controller up and running or are deploying it outside of this module.
- The access accounts are already onboarded or you are provisioning them outside of this module.
- Your Terraform workspace is configured with the correct parameters to connect to the controller (Username/password/host).

### Limitations

This module currently orchestrates these elements:

* Transit + peering
* Firenet
* Spoke gateways + attachments (No native spoke attachment)
* DCF Settings and policies
* Network segmentation

If you need other capabilities, like TGW-O, NAT or S2C, you need to add them in addition to this module. Future itterations of this module may resolve (some of) these limitations.

### How to use this

1. Add this module to your Terraform workspace.
   ```hcl
   module "poc" {
     source  = "terraform-aviatrix-modules/poc/aviatrix"
     version = "v1.0.0"

     datamodel = yamldecode(file("datamodel.yaml"))
   }
   ```
2. Copy the datamodel.yaml file from the module examples to your Terraform workspace and define your environment per the example.
3. Execute `terraform plan` and `terraform apply` to execute the changes.
