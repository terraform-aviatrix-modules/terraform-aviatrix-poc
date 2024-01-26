#Checks and error handling simplifying module usage.

resource "terraform_data" "input_validation" {
  lifecycle {

    #Make sure ha_region and ha_cidr aren't set when not deploying in GCP.
    precondition {
      condition     = local.global_settings != {} && local.global_settings != null
      error_message = "Global settings not found. Please make sure the datamodel contains a global_settings section."
    }
  }
}
