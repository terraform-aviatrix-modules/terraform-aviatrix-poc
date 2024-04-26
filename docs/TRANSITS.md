This document shows how to define the transits section and all of its configuration options. Firenet is also configured here. These arguments are fed into the mc-backbone module. All supported settings can be found on this [documentation page](https://github.com/terraform-aviatrix-modules/terraform-aviatrix-backbone).

The transits YAML structure
```yaml
transits: #Defines the section where transit firenet is defined
  transit1: #This is the name of the first transit entry in the structure. This name is only used within Terraform and does not define the name in the controller.

    # Mandatory arguments
    transit_cloud: aws                  #This defines the cloud in which the transit is deployed.
    transit_cidr: 10.1.0.0/23           #This defines the cidr used for creating the transit VPC/VNET/VCN.
    transit_region_name: eu-central-1   #This defines the region in which the transit is deployed.
    transit_asn: 65101                  #This defines the AS Number for this transit gateway

    # Optional arguments
    transit_account: AWS                #Which controller account to use. Mandatory if none is provided in the global settings

  transit2: #This is the name of the second transit entry in the structure.
    transit_cloud: azure                
    transit_cidr: 10.2.0.0/23           
    transit_region_name: West Europe    
    transit_asn: 65102        
    firenet: true          
```