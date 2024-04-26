This document shows how to define the global settings section and all of its configuration options.

These arguments are fed into the mc-backbone module. All supported settings can be found on this [documentation page](https://github.com/terraform-aviatrix-modules/terraform-aviatrix-backbone?tab=readme-ov-file#global-settings-for-transit-firenet-map).

For the mc-spoke module, the following global settings are also honered:
- `transit_account` the default account per cloud under which to deploy resources
- `transit_ha_gw` Whether to enable HA or not (default is true)

The transits YAML structure
```yaml
global_settings:
  #Default firenet images (Only used if firenet is enabled on a transit)
  firenet_firewall_image:
    aws: Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)
    azure: Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)
    gcp: Palo Alto Networks VM-Series Next-Generation Firewall BYOL
    oci: Palo Alto Networks VM-Series Next Generation Firewall

  #Default account names on the controller
  transit_accounts:
    aws: AWS
    azure: Azure
    gcp: GCP
    oci: OCI
    ali: ALI

  #By default everything is deployed in HA. Disabling this deploys single transit/spoke gateways and firenet instances.
  transit_ha_gw: true

```