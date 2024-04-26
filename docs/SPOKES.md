This document shows how to define the spokes section and all of its configuration options. These arguments are fed into the mc-spoke module. All supported settings can be found on this [documentation page](https://github.com/terraform-aviatrix-modules/terraform-aviatrix-mc-spoke).

The transits YAML structure
```yaml
spokes: #Defines the section where spokes are defined
  spoke1: #This is the name of the first spoke entry in the structure. This name is only used within Terraform and does not define the name in the controller.

    # Mandatory arguments
    name: MyFirstSpoke          #This defines the name of the spoke
    cloud: aws                  #This defines the cloud in which the spoke is deployed.
    cidr: 10.1.0.0/23           #This defines the cidr used for creating the spoke VPC/VNET/VCN.
    region: eu-central-1        #This defines the region in which the spoke is deployed.
    transit_gw: transit1        #This defines to which transit to connect the spoke. Refers to the name as you have defined it in the YAML code under transits.

    # Optional arguments
    account: AWS                #Which controller account to use. Mandatory if none is provided in the global settings

  spoke2: #This is the name of the second spoke entry in the structure.
    name: MySecondSpoke
    cloud: azure                
    cidr: 10.2.0.0/23           
    region: West Europe    
    attached: false             #When leaving the spoke detached, you are allowed to omit the transit_gw argument.
```