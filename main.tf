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

resource "aviatrix_distributed_firewalling_config" "enable_dcf" {
  count                          = local.dcf_policies != {} ? 1 : 0 #If there are DCF policies provided, automatically enable DCF.
  enable_distributed_firewalling = true
}

#DCF Policies
# resource "aviatrix_distributed_firewalling_policy_list" "test" {
#   for_each = {
#     "polcies" = each.value
#   }
# }
