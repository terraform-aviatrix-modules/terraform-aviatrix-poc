module "backbone" {
  source  = "terraform-aviatrix-modules/backbone/aviatrix"
  version = "v1.2.2"

  global_settings = local.global_settings
  transit_firenet = local.transits

  depends_on = [terraform_data.input_validation]
}

module "spokes" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.7"

  for_each = local.spokes

  cloud          = each.value.cloud
  name           = try(each.value.name, each.key)
  cidr           = try(each.value.cidr, null)
  region         = each.value.region
  account        = try(each.value.account, local.global_settings.transit_accounts[each.value.cloud], null)
  transit_gw     = try(each.value.attached, true) ? module.backbone.transit[each.value.transit_gw].transit_gateway.gw_name : null
  network_domain = try(each.value.network_domain, null)
  ha_gw          = try(each.value.ha_gw, local.global_settings.transit_ha_gw, null)
  attached       = try(each.value.attached, null)

  depends_on = [module.network_domains]
}

module "network_domains" {
  source  = "terraform-aviatrix-modules/mc-network-domains/aviatrix"
  version = "v1.0.0"

  connection_policies = local.connection_policies
  additional_domains  = local.network_domains

  depends_on = [terraform_data.input_validation]
}

resource "aviatrix_distributed_firewalling_config" "default" {
  enable_distributed_firewalling = local.dcf_enable
}

resource "aviatrix_smart_group" "default" {
  for_each = local.smart_groups

  name = "smart-group"
  selector {
    match_expressions {
      type         = "vm"
      account_name = "devops"
      region       = "us-west-2"
      tags = {
        k3 = "v3"
      }
    }

    match_expressions {
      cidr = "10.0.0.0/16"
    }

    match_expressions {
      fqdn = "www.aviatrix.com"
    }

    match_expressions {
      site = "site-test-0"
    }
  }

}

#DCF Policies
resource "aviatrix_distributed_firewalling_policy_list" "dcf_policies" {
  count = local.dcf_policies != {} ? 1 : 0

  dynamic "policies" {
    for_each = local.dcf_policies
    content {
      name     = policies.value.name
      action   = policies.value.action
      protocol = policies.value.protocol

      src_smart_groups = policies.value.src_smart_groups
      dst_smart_groups = policies.value.dst_smart_groups
      # port_ranges              = try(policies.value.port_ranges, {})
      exclude_sg_orchestration = try(policies.value.exclude_sg_orchestration, null)
      decrypt_policy           = try(policies.value.decrypt_policy, null)
      flow_app_requirement     = try(policies.value.flow_app_requirement, null)
      priority                 = try(policies.value.priority, null)
      web_groups               = try(policies.value.webgroups, null)
      logging                  = try(policies.value.logging, null)
      watch                    = try(policies.value.watch, null)
    }
  }
}

