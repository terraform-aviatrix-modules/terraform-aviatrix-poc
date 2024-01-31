This document shows how to define the transits section and all of its configuration options.

The transits YAML structure
```yaml
transits: #This is a mandatory key and the name transits should not be changed.
  transit1: #This is the name of the first transit entry in the structure. This name is only used within Terraform and does not define the name in the controller.

    #Mandatory attributes
    transit_cloud: aws                  #This defines the cloud in which the transit is deployed.
    transit_cidr: 10.1.0.0/23           #This defines the cidr used for creating the transit VPC/VNET/VCN.
    transit_region_name: eu-central-1   #This defines the region in which the transit is deployed.
    transit_asn: 65101                  #This defines the AS Number for this transit gateway

    #Optional attributes
    firenet: true
    -
    -
    -
    -
    -
    -
    -
    -
    -
  ```