

##############################################################################
# Create IKS/ROKS on VPC Cluster
##############################################################################

resource "ibm_container_vpc_cluster" "cluster" {
  count             = var.create_cluster ? 1 : 0
  name              = "${var.prefix}-cluster"
  vpc_id            = var.vpc_id
  resource_group_id = var.resource_group_id
  flavor            = var.machine_type
  worker_count      = var.workers_per_zone
  kube_version      = length(regexall(".*openshift", var.kube_version)) > 0 ? var.kube_version : null
  tags              = var.tags
  wait_till         = var.wait_till
  dynamic "zones" {
    for_each = var.subnets
    content {
      subnet_id = zones.value.id
      name      = zones.value.zone
    }
  }

  disable_public_service_endpoint = false

  timeouts {
    create = "2h"
  }

  # kms_config {
  #   instance_id      = var.key_id
  #   crk_id           = var.ibm_managed_key_id
  #   private_endpoint = true
  # }

}

##############################################################################


##############################################################################
# Worker Pools
##############################################################################

module "worker_pools" {
  source            = "./worker_pools"
  region            = var.region
  worker_pools      = var.worker_pools
  vpc_id            = var.vpc_id
  resource_group_id = var.resource_group_id
  cluster_name_id   = (var.create_cluster ? ibm_container_vpc_cluster.cluster[0].id : 0)
  subnets           = var.subnets
}

##############################################################################