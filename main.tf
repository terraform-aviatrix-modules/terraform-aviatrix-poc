module "backbone" {
  source  = "terraform-aviatrix-modules/backbone/aviatrix"
  version = "v1.2.2"

  global_settings = local.global_settings
  transit_firenet = local.transits

  depends_on = [terraform_data.input_validation]
}

module "spokes" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "v1.6.9"

  for_each = local.spokes

  cloud                                                = each.value.cloud
  name                                                 = try(each.value.name, each.key)
  cidr                                                 = try(each.value.cidr, null)
  region                                               = each.value.region
  account                                              = try(each.value.account, local.global_settings.transit_accounts[each.value.cloud], null)
  transit_gw                                           = try(each.value.attached, true) ? try(module.backbone.transit[each.value.transit_gw].transit_gateway.gw_name, null) : null
  network_domain                                       = try(each.value.network_domain, null)
  insane_mode                                          = try(each.value.insane_mode, null)
  ha_gw                                                = try(each.value.ha_gw, local.global_settings.transit_ha_gw, null)
  attached                                             = try(each.value.attached, null)
  bgp_lan_interfaces_count                             = try(each.value.bgp_lan_interfaces_count, null)
  enable_bgp_over_lan                                  = try(each.value.enable_bgp_over_lan, null)
  enable_bgp                                           = try(each.value.enable_bgp, null)
  local_as_number                                      = try(each.value.local_as_number, null)
  gw_name                                              = try(each.value.gw_name, null)
  ha_region                                            = try(each.value.ha_region, null)
  ha_cidr                                              = try(each.value.ha_cidr, null)
  instance_size                                        = try(each.value.instance_size, null)
  az1                                                  = try(each.value.az1, null)
  az2                                                  = try(each.value.az2, null)
  az_support                                           = try(each.value.az_support, null)
  transit_gw_egress                                    = try(each.value.transit_gw_egress, null)
  tunnel_count                                         = try(each.value.tunnel_count, null)
  egress_tunnel_count                                  = try(each.value.egress_tunnel_count, null)
  transit_gw_route_tables                              = try(each.value.transit_gw_route_tables, null)
  transit_gw_egress_route_tables                       = try(each.value.transit_gw_egress_route_tables, null)
  attached_gw_egress                                   = try(each.value.attached_gw_egress, null)
  single_az_ha                                         = try(each.value.single_az_ha, null)
  single_ip_snat                                       = try(each.value.single_ip_snat, null)
  customized_spoke_vpc_routes                          = try(each.value.customized_spoke_vpc_routes, null)
  filtered_spoke_vpc_routes                            = try(each.value.filtered_spoke_vpc_routes, null)
  included_advertised_spoke_routes                     = try(each.value.included_advertised_spoke_routes, null)
  subnet_pairs                                         = try(each.value.subnet_pairs, null)
  subnet_size                                          = try(each.value.subnet_size, null)
  enable_encrypt_volume                                = try(each.value.enable_encrypt_volume, null)
  customer_managed_keys                                = try(each.value.customer_managed_keys, null)
  private_vpc_default_route                            = try(each.value.private_vpc_default_route, null)
  skip_public_route_table_update                       = try(each.value.skip_public_route_table_update, null)
  auto_advertise_s2c_cidrs                             = try(each.value.auto_advertise_s2c_cidrs, null)
  tunnel_detection_time                                = try(each.value.tunnel_detection_time, null)
  tags                                                 = try(each.value.tags, null)
  use_existing_vpc                                     = try(each.value.use_existing_vpc, null)
  vpc_id                                               = try(each.value.vpc_id, null)
  gw_subnet                                            = try(each.value.gw_subnet, null)
  hagw_subnet                                          = try(each.value.hagw_subnet, null)
  resource_group                                       = try(each.value.resource_group, null)
  inspection                                           = try(each.value.inspection, null)
  spoke_bgp_manual_advertise_cidrs                     = try(each.value.spoke_bgp_manual_advertise_cidrs, null)
  bgp_ecmp                                             = try(each.value.bgp_ecmp, null)
  enable_active_standby                                = try(each.value.enable_active_standby, null)
  prepend_as_path                                      = try(each.value.prepend_as_path, null)
  bgp_polling_time                                     = try(each.value.bgp_polling_time, null)
  bgp_hold_time                                        = try(each.value.bgp_hold_time, null)
  enable_learned_cidrs_approval                        = try(each.value.enable_learned_cidrs_approval, null)
  learned_cidrs_approval_mode                          = try(each.value.learned_cidrs_approval_mode, null)
  approved_learned_cidrs                               = try(each.value.approved_learned_cidrs, null)
  subnet_groups                                        = try(each.value.subnet_groups, null)
  rx_queue_size                                        = try(each.value.rx_queue_size, null)
  availability_domain                                  = try(each.value.availability_domain, null)
  ha_availability_domain                               = try(each.value.ha_availability_domain, null)
  fault_domain                                         = try(each.value.fault_domain, null)
  ha_fault_domain                                      = try(each.value.ha_fault_domain, null)
  enable_preserve_as_path                              = try(each.value.enable_preserve_as_path, null)
  private_mode_lb_vpc_id                               = try(each.value.private_mode_lb_vpc_id, null)
  enable_max_performance                               = try(each.value.enable_max_performance, null)
  private_mode_subnets                                 = try(each.value.private_mode_subnets, null)
  spoke_prepend_as_path                                = try(each.value.spoke_prepend_as_path, null)
  transit_prepend_as_path                              = try(each.value.transit_prepend_as_path, null)
  enable_monitor_gateway_subnets                       = try(each.value.enable_monitor_gateway_subnets, null)
  group_mode                                           = try(each.value.group_mode, null)
  spoke_gw_amount                                      = try(each.value.spoke_gw_amount, null)
  manage_ha_gateway                                    = try(each.value.manage_ha_gateway, null)
  additional_group_mode_subnets                        = try(each.value.additional_group_mode_subnets, null)
  additional_group_mode_azs                            = try(each.value.additional_group_mode_azs, null)
  allocate_new_eip                                     = try(each.value.allocate_new_eip, null)
  eip                                                  = try(each.value.eip, null)
  ha_eip                                               = try(each.value.ha_eip, null)
  azure_eip_name_resource_group                        = try(each.value.azure_eip_name_resource_group, null)
  ha_azure_eip_name_resource_group                     = try(each.value.ha_azure_eip_name_resource_group, null)
  additional_group_mode_eips                           = try(each.value.additional_group_mode_eips, null)
  additional_group_mode_azure_eip_name_resource_groups = try(each.value.additional_group_mode_azure_eip_name_resource_groups, null)
  disable_route_propagation                            = try(each.value.disable_route_propagation, null)
  enable_global_vpc                                    = try(each.value.enable_global_vpc, null)
  enable_gro_gso                                       = try(each.value.enable_gro_gso, null)
  additional_gcp_subnets                               = try(each.value.additional_gcp_subnets, null)
  enable_vpc_dns_server                                = try(each.value.enable_vpc_dns_server, null)
  enable_active_standby_preemptive                     = try(each.value.enable_active_standby_preemptive, null)

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
