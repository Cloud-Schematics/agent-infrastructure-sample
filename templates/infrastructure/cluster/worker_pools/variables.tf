

##############################################################################
# Worker Pool Variables
##############################################################################

variable worker_pools {
    description = "List of maps describing worker pools"

    type        = list(object({
        name        = string
        machine_type     = string
        workers_per_zone = number
    }))

    default     = []

    validation  {
        error_message = "Worker pool names must match the regex `^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$`."
        condition     = length([
            for pool in var.worker_pools:
            false if !can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", pool.name))
        ]) == 0
    }

    validation {
        error_message = "Worker pools cannot have duplicate names."
        condition     = length(distinct([
            for pool in var.worker_pools:
            pool.name
        ])) == length(var.worker_pools)
    }

    validation {
        error_message = "Worker pools must have at least two workers per zone."
        condition     = length([
            for pool in var.worker_pools:
            false if pool.workers_per_zone < 2
        ]) == 0
    }

}

variable vpc_id {
    description = "VPC where the cluster is provisioned"
    type        = string
}

variable resource_group_id {
    description = "ID of the group where the pool will be provisioned"
    type        = string
}

variable cluster_name_id {
    description = "Name or ID of cluster where pool will be provisioned"
    type        = string
}

variable subnets {
    description = "A map containing cluster subnet IDs and subnet zones"
    type        = list(object({
        id   = string
        zone = string
        cidr = string
        name = string
    }))
}


variable region {
    description = "IBM Cloud loation where all resources will be deployed"
    type        = string
}

##############################################################################