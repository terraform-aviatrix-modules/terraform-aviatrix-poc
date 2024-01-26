# Terraform Aviatrix PoC

### Description

\This module provides a simplified way to deploy a PoC environment, by taking a YAML datamodel and deploying all resources, without the need to write actual Terraform code.

### Compatibility

| Module version | Terraform version | Controller version | Terraform provider version |
| :------------- | :---------------- | :----------------- | :------------------------- |
| v1.0.0         | >= 1.4.0          | 7.1                | ~> 3.1.0                  |

### How to use this

1. Create a new Terraform workspace and call this module
2. Edit
3. Set up your controller credentials using environmental variables by running this in your bash shell.

```bash
export AVIATRIX_CONTROLLER_IP="controller_fqdn_or_ip"
export AVIATRIX_USERNAME="admin"
export AVIATRIX_PASSWORD='mysecretpassword'
```
