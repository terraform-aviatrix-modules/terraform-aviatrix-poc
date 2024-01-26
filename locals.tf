locals {
  #Global settings
  global_settings = try(var.datamodel.global_settings, {}) #If global_settings is not found in var.datamodel, return an empty map

  #Spokes, transits and firenet config
  transits = coalesce(var.datamodel.transits, {}) #If transits is not found in var.datamodel or is empty, return an empty map
  spokes   = coalesce(var.datamodel.spokes, {})   #If spokes is not found in var.datamodel or is empty, return an empty map

  #DCF Config
  dcf_policies = coalesce(var.datamodel.dcf.dcf_policies, {}) #If dcf_policies is not found in var.datamodel or is empty, return an empty map
  dcf_enable   = try(var.datamodel.dcf.dcf_enable, false)
  smart_groups = coalesce(var.datamodel.dcf.smart_groups, {})

  #Network segmentation
  network_domains     = try(var.datamodel.network_segmentation.network_domains, [])     #If network_domains is not found in var.datamodel or is empty, return an empty list
  connection_policies = try(var.datamodel.network_segmentation.connection_policies, []) #If connection_policies is not found in var.datamodel or is empty, return an empty list
}
