This document shows how to define the network segmentation section and all of its configuration options. These arguments are fed into the mc-network-domains module. All supported settings can be found on this [documentation page](https://github.com/terraform-aviatrix-modules/terraform-aviatrix-mc-network-domains).

The transits YAML structure
```yaml
network_segmentation: #Defines the section where network segmentation is defined.
  connection_policies: #This defines a list of connection policies. Domains listed here will automatically be created.
    - [blue, red]
    - [green, blue]
   
  #If you need to provision other domains, but not create a connection policy for them, you can list them here.
  network_domains:
    - yellow