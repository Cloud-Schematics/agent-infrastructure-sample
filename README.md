# Schematics Agents

The IBM Cloud Schematics Agents extends Schematics ability to reach your private, or on-premises, infrastructure. Integrate the Schematics Agents running in your private network to the IBM Cloud Schematics service to provision, configure, and operate your private or on-premise cloud cluster resources without any time, network, or software restrictions.

This Agent repository helps you to provision the infrastructure required for an Agent and deploys the services on the provisioned infrastructure.


## Release notes
This release contains the following fixes
- Ability to skip SSL certificate validation when using Self-Signed server certificates in private GHE
- Intermittent `409` error for JobRunner Service
- Incomplete runtime logs
- Bug Fixes


## Table of Contents

1. [Prerequisites](##Prerequisites)
2. [Agents deployment](##Agents-Deployment)
3. [Using tar files](##Using-Tar-Files)
4. [Infrastructure](##Infrastructure)
5. [Service](##Service)
6. [Terraform versions](##Terraform-Versions)
7. [Inputs](##Inputs)
8. [Outputs](##Outputs)
9. [Next Steps](##Next-Steps)

## Prerequisites

1. Make sure that you are [assigned the correct permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to create the workspace and deploy resources.
2. Make sure that you have the [required IBM Cloud IAM permissions](https://cloud.ibm.com/docs/vpc?topic=vpc-managing-user-permissions-for-vpc-resources) to create and work with VPC infrastructure and you are [assigned the correct permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to create the workspace and deploy the resources.
3. Make sure that you have the [required IBM Cloud IAM permissions](https://cloud.ibm.com/docs/containers?topic=containers-access_reference) to create and work with IBM Cloud Cluster.
4. Make sure that you have the [required IBM Cloud IAM permissions](https://cloud.ibm.com/docs/log-analysis?topic=log-analysis-iam) to create and work with IBM Log Analysis.
5. Make sure that you have the [required IBM Cloud IAM permissions](https://cloud.ibm.com/docs/activity-tracker?topic=activity-tracker-iam) to create and work with IBM Activity tracker.

## Terraform versions

|  **Name**                  | **Version** |
|  --------------------------| -------------|
|  terraform                 | ~> 1.5 |
|  terraform_provider_ibm    | ~> 1.60 |

## Agents deployment

This repository has `.tf` configuration for the deployment of Agent infrastructure.

```text
├── templates
|   └── infrastructure
```


## Infrastructure
    
The `agent-infrastructure-templates.tar` is a Terraform configuration archive files which provisions Agent infrastructure on IBM Cloud. A collection of following services are provisioned.
- VPC
- IBM Kubernetes cluster
- IBM Log Analysis
- Activity Tracker



## Inputs

| name | description | type | required | default | sensitive |
| ---------- | -------- | -------------- | ---------- | ----------- | ----------- |
| agent_prefix | You will use this prefix, for `vpc`, `cluster`, and  `observability`. (Maximum length 27 chars) |  |  | my-project |  |
| location | Location of the Agent infrastructure.  |  |  | `us-south` |  |
| resource_group_name | Name of resource group used where agent infrastructure will be provisioned. | string | &check; | |  |
| tags | A list of tags for the agent infrastructure | list(string) | | my-project:agent | |
| ibmcloud_api_key | The IBM Cloud API Key used to provision the Schematics agent infrastructure resources. If not provided, then resources will be provisioned in currently logged in user account. | string | | | &check; |
| resource_group_name | Name of resource group used where agent infrastructure was provisioned. | string | &check; | | |
| ibmcloud_api_key | The IBM Cloud API Key used to deploy the schematics agent resources. If not provided, resources will be deployed using the logged in user credentials. | string | | | &check; |

## Outputs

- Click [here](https://cloud.ibm.com/docs/schematics?topic=schematics-agents-setup&interface=ui#agents-setup-infra-output) to view the Agent infrastructure workspace setup. 

## Next Steps

You have completed the agent infrastructure setup for your Schematics agent instance.
   - Now, you need to [deploy your agent](https://cloud.ibm.com/docs/schematics?topic=schematics-register-agent&interface=ui#register-ui) service with your Schematics service instance.
   - And, to use an Agent, you need to [bind the Agent](https://cloud.ibm.com/docs/schematics?topic=schematics-using-agent&interface=ui#steps-bind-new-wks) to new Workspace or existing workspace, in order to run the IaC automation in your cluster.
