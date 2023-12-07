

##############################################################################
# Create Activity Tracker
##############################################################################

resource "ibm_resource_instance" "activity_tracker" {
  count             = var.create_activity_tracker == true ? 1 : 0
  name              = "${var.prefix}-activity-tracker"
  service           = "logdnaat"
  plan              = var.logdna_plan
  location          = var.region
  resource_group_id = var.resource_group_id
  parameters = {
    service-endpoints = var.service_endpoints
  }

  tags = var.tags
}
##############################################################################


##############################################################################
# LogDNA
##############################################################################

resource "ibm_resource_instance" "logdna" {
  count             = var.enable_observability == true ? 1 : 0
  name              = "${var.prefix}-logdna"
  location          = var.region
  plan              = var.logdna_plan
  resource_group_id = var.resource_group_id
  service           = "logdna"
  service_endpoints = var.service_endpoints
  tags              = var.tags
}

##############################################################################


##############################################################################
# Sysdig
##############################################################################

# resource "ibm_resource_instance" "sysdig" {
#   count             = var.enable_observability == true ? 1 : 0
#   name              = "${var.prefix}-sysdig"
#   location          = var.region
#   plan              = var.sysdig_plan
#   resource_group_id = var.resource_group_id
#   service           = "sysdig-monitor"
#   service_endpoints = var.service_endpoints
# }

##############################################################################