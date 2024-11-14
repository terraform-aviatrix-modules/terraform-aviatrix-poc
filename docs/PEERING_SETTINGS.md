This document shows how to define the peering settings for the transits. These arguments are fed into the mc-backbone module. All supported settings can be found on this [documentation page](https://github.com/terraform-aviatrix-modules/terraform-aviatrix-backbone).

By default transits are peered full mesh, in what is described as "optimized" mode in the mc-backbone module. Find more information on peering in this [document](https://github.com/terraform-aviatrix-modules/terraform-aviatrix-backbone/blob/main/docs/PEERING.md).

The transits YAML structure
```yaml
peering_settings: #Defines the section where peering is defined
  excluded_cidrs: #A list of CIDRs to be excluded from peering (Only to be used with Full Mesh or Optimized Full Mesh mode)
    - 10.0.0.0/8
    - 192.168.1.0/24

  peering_mode: custom

  peering_map:
    peering1:
      gw1_name: transit1
      gw2_name: transit2
      enable_peering_over_private_network: true
    peering2:
      gw1_name: transit1
      gw2_name: transit3
      gateway1_excluded_network_cidrs:
        - 0.0.0.0/0
      gateway2_excluded_network_cidrs:
        - 0.0.0.0/0"

  peering_prune_list: #List of peerings to be ommitted (Only to be used with Full Mesh or Optimized Full Mesh mode)
    - transit2: transit3
    - transit4: transit5
```