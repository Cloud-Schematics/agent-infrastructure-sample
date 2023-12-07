# IBM Cloud Schematics Agent Infrastructure

This is an terraform configuration which provisions Agent Infrastructure on IBM Cloud.

## Agent Infra Architecture

## What will this do?

This is a Terraform configuration that will create 
- VPC
- IBM VPC Cluster
- LogDNA
- Activity Tracker
- Security Gropus

Link this repository to the schematics workspace and run `Generate Plan` and `Apply Plan` to create the agent infrastructure.

## Prerequisites

1. Make sure that you have the [required IBM Cloud IAM
    permissions](https://cloud.ibm.com/docs/vpc?topic=vpc-managing-user-permissions-for-vpc-resources) to
    create and work with VPC infrastructure and you are [assigned the
    correct
    permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to
    create the workspace and deploy resources.
2. The terraform version should be ~> 1.0
3. The terraform ibm provider  version should be ~> 1.42


## Inputs

| name | description | type | required | default | sensitive |
| ---------- | -------- | -------------- | ---------- | ----------- | ----------- |
| agent_prefix | You will use this prefix, for vpc, cluster and  observability. (Max length 27 chars) |  |  | my-project |  |
| location | Location of the agent infrastructure.  Note: For Beta, the agent must be deployed in a freshly provisioned VPC, IKS Cluster, Log Analysis instance. |  |  | us-south |  |
| resource_group_name | Name of resource group used where agent infrastructure was provisioned. | string | &check; | |  |
| tags | A list of tags for the agent infrastructure | list(string) | | my-project:agent | |
| ibmcloud_api_key | The IBM Cloud API Key used to provision the schematics agent infrastructure resources. If not provided, then resources will be provisioned in currently logged in user account. | string | | | &check; |


## Outputs

|  **name**      |    **description**  |
|  --------------------------------------- | ------------------------------------------- |
| vpc_id | ID of VPC created |
| acls | ID of ACL created for subnets |
| public_gateways | Public gateways created |
| subnet_ids | The IDs of the subnets | 
| subnet_detail_list | A list of subnets containing names, CIDR blocks, and zones. |
| subnet_zone_list | A list containing subnet IDs and subnet zones |
| subnet_tier_list | An object containing tiers, each key containing a list of subnets in that tier |
| cluster_id | ID of cluster created |
| cluster_name | Name of cluster created |
| cluster_private_service_endpoint_url | URL For Cluster Private Service Endpoint |
| cluster_private_service_endpoint_port | Port for Cluster private service endpoint |
| logdna_name | Name of LogDna created |

## How to create Agent Infrastructure using Schematics

1.  From the IBM Cloud menu
    select [Schematics](https://cloud.ibm.com/schematics/overview).
       - enter the URL of this example in the Schematics examples Github repository.
       - Click Next
       - Enter a name for your workspace.
       - Select the Terraform version: Terraform 1.0 or higher
       - Click Next to review   
       - Click Create to create your workspace.
2.  On the workspace **Settings** page, 
     - In the **Input variables** section, review the default input
        variables and provide alternatives if desired. The only
        mandatory parameter is the name given to the Resource group.
      - Click **Save changes**.

4.  From the workspace **Settings** page, click **Generate plan** 
5.  Click **View log** to review the log files of your Terraform
    execution plan.
6.  Apply your Terraform template by clicking **Apply plan**.
7.  Review the log file to ensure that no errors occurred during the
    provisioning, modification, or deletion process.

The output of the Schematics Apply Plan will list the cluster Id,
logdna name. These can be used for input to subsequent service deployment templates.
