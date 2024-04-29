#Checks and error handling simplifying module usage.

resource "terraform_data" "input_validation" {
  lifecycle {

    #Check to see if reserved names "any" and "internet" are not beng used by a defined smartgroup.
    precondition {
      condition = alltrue([
        !contains(keys(local.smart_groups), "any"),
        !contains(keys(local.smart_groups), "internet"),
      ])
      error_message = "Please do not use \"any\" and \"internet\" in your Smartgroups, as these names are reserved for pre-provisioned smartgroups."
    }

    #Check that only defined smartgroups are used in the policies.
    precondition {
      condition = alltrue([
        for i in local.dcf_policies_smartgroups : contains(keys(local.enriched_smart_groups), i)
      ])

      error_message = "Make sure all smartgroups referenced in your policies are defined under smartgroups."
    }

  }
}
