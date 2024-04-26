This document shows how to define the distributed cloud firewall section and all of its configuration options.

The policies are fed into the `aviatrix_distributed_firewalling_policy_list` resource. To see all available arguments, check this [documentation page](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_distributed_firewalling_policy_list).

The smartgroups are fed into the `aviatrix_smart_group` resource. To see all available arguments, check this [documentation page](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_smart_group).

A smartgroup `any` and `internet` have already been predefined. You can use these without having to define them.

The webgroups are fed into the `aviatrix_web_group` resource. To see all available arguments, check this [documentation page](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_web_group).

The transits YAML structure
```yaml
dcf: #Defines the section where DCF is defined.
  #Enable/disable DCF
  dcf_enable: true

  #Create DCF policies
  dcf_policies: #Add all policies. Make sure the used web and smartgroups are defined under web_groups and smart_groups
    policy1: #First policy entry
      name: MyPolicy1
      action: permit
      protocol: tcp
      src_smart_groups:
        - production-servers
      dst_smart_groups:
        - dns
      web_groups:
        - news
    
    policy2: #Second policy entry
      name: MyPolicy2
      action: permit
      protocol: tcp
      src_smart_groups:
        - development-servers
      dst_smart_groups:
        - dns

    policy3: #Third policy entry
      name: MyPolicy3
      action: permit
      protocol: tcp
      src_smart_groups:
        - vdi
      dst_smart_groups:
        - internet
      web_groups:
        - news
    

  #Create smart groups
  smart_groups: #Add all smart groups.
    production-servers: #First smartgroup
      match_expressions:
        expression1:
          type: vm
          account_name: devops
          region: us-west-2
          tags:
            env: prod
            class: server
            type: web

    development-servers: #Second smartgroup
      match_expressions:
        expression1:
          type: vm
          account_name: devops
          region: us-west-2
          tags:
            env: dev
            class: server
            type: web

    vdi: #Third smartgroup
      match_expressions:
        expression1:
          type: vm
          account_name: users
          region: us-west-2
          tags:
            env: prod
            class: desktop
            type: vdi       

  #Create web groups
  web_groups: #Add all web groups.

    aviatrix_urls: #First web group
      match_expressions:
        expression1:
          urlfilter: https://aviatrix.com/test
        expression2:
          urlfilter: https://aviatrix.com/test2          

    news: #Second web group
      match_expressions:
        expression1:
          snifilter: www.cnn.com
        expression2:
          snifilter: www.msnbc.com