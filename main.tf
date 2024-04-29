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

  cloud                    = each.value.cloud
  name                     = try(each.value.name, each.key)
  cidr                     = try(each.value.cidr, null)
  region                   = each.value.region
  account                  = try(each.value.account, local.global_settings.transit_accounts[each.value.cloud], null)
  transit_gw               = try(each.value.attached, true) ? try(module.backbone.transit[each.value.transit_gw].transit_gateway.gw_name, null) : null
  network_domain           = try(each.value.network_domain, null)
  insane_mode              = try(each.value.insane_mode, null)
  ha_gw                    = try(each.value.ha_gw, local.global_settings.transit_ha_gw, null)
  attached                 = try(each.value.attached, null)
  bgp_lan_interfaces_count = try(each.value.bgp_lan_interfaces_count, null)
  enable_bgp_over_lan      = try(each.value.enable_bgp_over_lan, null)
  enable_bgp               = try(each.value.enable_bgp, null)
  local_as_number          = try(each.value.local_as_number, null)

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
  count                          = local.dcf_enable != null ? 1 : 0
  enable_distributed_firewalling = local.dcf_enable
}

resource "aviatrix_smart_group" "smartgroups" {
  for_each = local.smart_groups

  name = each.key
  selector {
    dynamic "match_expressions" {
      for_each = each.value.match_expressions
      content {
        type         = try(match_expressions.value.type, null)
        region       = try(match_expressions.value.region, null)
        account_id   = try(match_expressions.value.account_id, null)
        account_name = try(match_expressions.value.account_name, null)
        cidr         = try(match_expressions.value.cidr, null)
        fqdn         = try(match_expressions.value.fqdn, null)
        site         = try(match_expressions.value.site, null)
        zone         = try(match_expressions.value.zone, null)
        tags         = try(match_expressions.value.tags, null)
        res_id       = try(match_expressions.value.res_id, null)
        name         = try(match_expressions.value.name, null)
      }
    }
  }

  depends_on = [aviatrix_distributed_firewalling_config.default]
}

resource "aviatrix_web_group" "webgroups" {
  for_each = local.web_groups

  name = each.key
  selector {
    dynamic "match_expressions" {
      for_each = each.value.match_expressions
      content {
        snifilter = try(match_expressions.value.snifilter, null)
        urlfilter = try(match_expressions.value.urlfilter, null)
      }
    }
  }

  depends_on = [aviatrix_distributed_firewalling_config.default]
}

#DCF Policies
resource "aviatrix_distributed_firewalling_policy_list" "dcf_policies" {
  count = local.dcf_policies != {} ? 1 : 0

  dynamic "policies" {
    for_each = local.dcf_policies
    content {
      name     = policies.key
      action   = upper(policies.value.action)
      protocol = policies.value.protocol

      src_smart_groups         = [for i in policies.value.src_smart_groups : local.enriched_smart_groups[i].uuid]
      dst_smart_groups         = [for i in policies.value.dst_smart_groups : local.enriched_smart_groups[i].uuid]
      exclude_sg_orchestration = try(policies.value.exclude_sg_orchestration, null)
      decrypt_policy           = try(policies.value.decrypt_policy, null)
      flow_app_requirement     = try(policies.value.flow_app_requirement, null)
      priority                 = try(policies.value.priority, null)
      web_groups               = try([for i in policies.value.web_groups : aviatrix_web_group.webgroups[i].uuid], null)
      logging                  = try(policies.value.logging, null)
      watch                    = try(policies.value.watch, null)

      dynamic "port_ranges" {
        for_each = try([policies.value.port_ranges], [])
        content {
          hi = try(port_ranges.value.hi, null)
          lo = port_ranges.value.lo
        }
      }
    }
  }

  depends_on = [
    aviatrix_smart_group.smartgroups,
    aviatrix_distributed_firewalling_config.default,
    terraform_data.input_validation
  ]
}
