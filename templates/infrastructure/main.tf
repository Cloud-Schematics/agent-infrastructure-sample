

##############################################################################
# IBM Cloud Provider
##############################################################################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.location
  ibmcloud_timeout = 60
}

##############################################################################


##############################################################################
# Resource Group where VPC will be created
##############################################################################

data "ibm_resource_group" "resource_group" {
  name = var.resource_group_name
}


##############################################################################

##############################################################################
# Create VPC
##############################################################################

module "multizone_vpc" {
  count                = (local.create_cluster ? 1 : 0)
  create_vpc           = local.create_cluster
  source               = "./vpc"
  prefix               = var.agent_prefix
  region               = var.location
  resource_group_id    = data.ibm_resource_group.resource_group.id
  classic_access       = local.classic_access
  subnet_tiers         = local.subnet_tiers
  use_public_gateways  = local.use_public_gateways
  network_acls         = local.network_acls
  security_group_rules = local.security_group_rules
}

##############################################################################

##############################################################################
# observability
##############################################################################

module "observability" {
  count                = (local.enable_observability ? 1 : 0)
  enable_observability = local.enable_observability
  source               = "./observability"
  prefix               = var.agent_prefix
  region               = var.location
  resource_group_id    = data.ibm_resource_group.resource_group.id
}

##############################################################################


##############################################################################
# Create Cluster
##############################################################################


module "vpc_cluster" {
  count          = (local.create_cluster ? 1 : 0)
  create_cluster = local.create_cluster
  source         = "./cluster"
  # Account Variables
  prefix            = var.agent_prefix
  region            = var.location
  resource_group_id = data.ibm_resource_group.resource_group.id
  # VPC Variables
  vpc_id  = (local.create_cluster ? module.multizone_vpc[0].vpc_id : 0)
  subnets = module.multizone_vpc[0].subnet_tier_list["vpc"]
  # Cluster Variables
  machine_type     = local.machine_type
  workers_per_zone = local.workers_per_zone
  tags             = var.tags
  worker_pools     = local.worker_pools
}

##############################################################################