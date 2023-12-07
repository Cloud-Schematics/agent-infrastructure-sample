

##############################################################################
# Variables
##############################################################################

variable "enable_observability" {
  description = "True to create new Observability Services. False if Observability Service instances are already existing."
  type        = bool
}

variable "prefix" {
  description = "A unique identifier need to provision resources. Must begin with a letter"
  type        = string
  default     = "my-project"

  validation {
    error_message = "Unique ID must begin and end with a letter and contain only letters, numbers, and - characters."
    condition     = can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", var.prefix))
  }
}

variable "region" {
  description = "Region where resources will be created"
  type        = string
  default     = "us-south"

  validation {
    error_message = "Can only be provisioned in au-syd, eu-de, us-east, or us-south."
    condition     = contains(["us-south", "au-syd", "eu-de", "us-east"], var.region)
  }
}

variable "resource_group_id" {
  description = "ID of the resource group where instances will be created"
  type        = string
}

variable "tags" {
  description = "A list of tags to be added to resources"
  type        = list(string)
  default     = ["my-project:agent"]
}


# variable "sysdig_plan" {
#   description = "Type of sysdig plan. Can be `graduated-tier` or `graduated-tier-sysdig-secure-plus-monitor`"
#   type        = string
#   default     = "graduated-tier"

#   validation {
#     error_message = "Can only be `mongodb` or `graduated-tier-sysdig-secure-plus-monitor`."
#     condition     = contains(["graduated-tier", "graduated-tier-sysdig-secure-plus-monitor"], var.sysdig_plan)
#   }
# }

variable "logdna_plan" {
  description = "Type of logdna and activity tracker plan. Can be `14-day`, `30-day`, `7-day`, or `hipaa-30-day`"
  type        = string
  default     = "7-day"

  validation {
    error_message = "Can only be `14-day`, `30-day`, `7-day`, or `hipaa-30-day`."
    condition     = contains(["14-day", "30-day", "7-day", "hipaa-30-day"], var.logdna_plan)
  }
}

variable "create_activity_tracker" {
  description = "Create activity tracker. Only one instance of activity tracker can be provisioned per region in each account."
  type        = bool
  default     = false
}

variable "service_endpoints" {
  description = "Service endpoints. Can be `public`, `private`, or `public-and-private`"
  type        = string
  default     = "private"

  validation {
    error_message = "Service endpoints can only be `public`, `private`, or `public-and-private`."
    condition     = contains(["public", "private", "public-and-private"], var.service_endpoints)
  }
}

##############################################################################