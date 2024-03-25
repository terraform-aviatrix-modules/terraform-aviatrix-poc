#Checks and error handling simplifying module usage.

resource "terraform_data" "input_validation" {
  lifecycle {

    #Make sure global settings are set.
    precondition {
      condition     = local.global_settings != {} && local.global_settings != null
      error_message = "Global settings not found. Please make sure the datamodel contains a global_settings section."
    }

    #Add check to see if reserved names "any" and "internet" are not beng used by a defined smartgroup.
    precondition {
      condition = alltrue([
        !contains(keys(local.smart_groups), "any"),
        !contains(keys(local.smart_groups), "internet"),
      ])
      error_message = "Please do not use \"any\" and \"internet\" in your Smartgroups, as these names are reserved for pre-provisioned smartgroups."
    }
  }
}
