locals {
  #Global settings
  global_settings = try(var.datamodel.global_settings, {}) #If global_settings is not found in var.datamodel, return an empty map

  #Spokes, transits and firenet config
  transits = coalesce(var.datamodel.transits, {}) #If transits is not found in var.datamodel or is empty, return an empty map
  spokes   = coalesce(var.datamodel.spokes, {})   #If spokes is not found in var.datamodel or is empty, return an empty map

  #DCF Config
  dcf_policies = try(var.datamodel.dcf.dcf_policies, {}) #If dcf_policies is not found in var.datamodel or is empty, return an empty map
  dcf_enable   = try(var.datamodel.dcf.dcf_enable, false)
  smart_groups = try(var.datamodel.dcf.smart_groups, {})

  default_smart_groups = {
    Anywhere       = { uuid = "def000ad-0000-0000-0000-000000000000" },
    PublicInternet = { uuid = "def000ad-0000-0000-0000-000000000001" }
  }
  enriched_smart_groups = merge(aviatrix_smart_group.smartgroups, local.default_smart_groups)

  web_groups = try(var.datamodel.dcf.web_groups, {})

  #Network segmentation
  network_domains     = try(var.datamodel.network_segmentation.network_domains, [])     #If network_domains is not found in var.datamodel or is empty, return an empty list
  connection_policies = try(var.datamodel.network_segmentation.connection_policies, []) #If connection_policies is not found in var.datamodel or is empty, return an empty list
}

output "enriched" {
  value = local.enriched_smart_groups
}
