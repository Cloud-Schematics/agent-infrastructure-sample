# Schematics Agents - Infrastructure setup

## Introduction

Schematics Agent is an Experimental feature, this guide describes the steps to setup your Cloud account and resources before deploying the Agent micro-services.

## Summary of steps

* Use the terraform template to create a `Schematics Agents Infrastructure Workspace`.
* Use the `Schematics Agents Infrastructure Workspace` to provision resources required for the agent.

### Prerequisites
{: #agents-setup-prereq}

Before you begin deploying the agent infrastructure, ensure the following prerequisites are met.

- You must have an [{{site.data.keyword.cloud_notm}} Pay-As-You-Go or Subscription](https://cloud.ibm.com/registration){: external} account to proceed. For more information about managing your {{site.data.keyword.cloud_notm}}, see [Setting up your {{site.data.keyword.cloud_notm}} account](/docs/account?topic=account-account-getting-started).
- Check whether you have the permissions to [provision a VPC](/docs/vpc?topic=vpc-resource-authorizations-required-for-api-and-cli-calls), a [{{site.data.keyword.containerlong_notm}} cluster](/docs/containers?topic=containers-access_reference#cluster_create_permissions), and [logging service](/docs/log-analysis?topic=log-analysis-iam_manage_events) in the target resource group.
- Check whether you have the [permissions](/docs/schematics?topic=schematics-access#workspace-permissions) to create a workspace.

## Provisioning agent infrastructure using {{site.data.keyword.bpshort}}
{: #agents-infra-workspace}

{{site.data.keyword.bpshort}} provides a sample template [https://github.com/Cloud-Schematics/schematics-agents/tree/main/templates/infrastructure](https://github.com/Cloud-Schematics/schematics-agents/tree/main/templates/infrastructure){: external} that you can use to provision the infrastructure required by your agent. The Agent infrastructure is composed of the following resources.

- [VPC infrastructure](/docs/vpc?topic=vpc-iam-getting-started) as `public_gateways`, `subnets`.
- [IKS](/docs/containers?topic=containers-access_reference) as `vpc_kubernetes_cluster`.
- [LogDNA](/docs/log-analysis?topic=log-analysis-iam)
- [Activity tracker](/docs/activity-tracker?topic=activity-tracker-iam)

1. Log in to [{{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/){: external}.
2. Navigate to **Schematics** > **Workspaces** > [**Create workspace**](https://cloud.ibm.com/schematics/workspaces/create){: external} with the following inputs to create an Agent infrastructure workspace.
    - In **Specify Template** section:
        - **GitHub, GitLab or Bitbucket repository URL** - `https://github.com/Cloud-Schematics/schematics-agents/tree/main/templates/infrastructure`.
        - **Personal access token** - `<leave it blank>`.
        - Terraform Version - `terraform_v1.0`. Note that you need to select Terraform version 1.0 or greater than version.
        - Click `Next`.
    - In **Workspace details** section:
        - **Workspace name** as `schematics-agent-infrastructure`.
        - **Tags** as `agents-infra`. 
        - **Resource group** as `default` or other resource group for this workspace. For more information, see [Creating a resource group](/docs/account?topic=account-rgs). Ensure you have right access permission for the resource group.
        - **Location** as `North America` or other [region](/docs/schematics?topic=schematics-multi-region-deployment) for this workspace. 
           If the location used for Agent infrastructure and Agent service does not match, then the logs are not sent to LogDNA.
           {: note}

        - Click `Next`.
        - Check the information entered are correct to create a workspace.
    - Click `Create`.

3. On successful creation of the `schematics-agent-infrastructure` Workspace, review and edit the `agent infrastructure` input variables in the workspace **Settings** page.

    The agent infrastructure and the workspace can be in different resource groups and locations. The agent infrastructure workspace can be defined in any {{site.data.keyword.bpshort}} supported region. 
    {: note} 

    | Input variable  | Data type | Required/Optional | Description |
    |--|--|--| -- |
    | `agent_prefix` | String | Required | Provide the prefix for naming your agent VPC, cluster, and logging configuration.
    | `location`| String | Required | The region in the agent infrastructure VPC and cluster will be created in. |
    | `resource_group_name` | String | Required | Name for the resource group used the agent infrastructure and agent will be associated to. For example, **`test_agent`**. For more information, see [Creating a resource group](/docs/account?topic=account-rgs). Ensure you have right access permission for the resource group. |
    | `ibmcloud_api_key` | String | Optional | The {{site.data.keyword.cloud_notm}} API key used to provision the {{site.data.keyword.bpshort}} Agent infrastructure resources. If not provided, resources provisions in currently logged in user credentials.|
    | `tags` | List(String) | Optional | A list of user tags to be applied to the deployed, VPC and cluster. For example, `myproject:agent`, `test:agentinfra`. You can find the provisioned resources of an Agent faster by using Tag name. |
    {: caption="{{site.data.keyword.bpshort}} Agents infrastructure inputs" caption-side="bottom"}

4. Click **Apply plan** on the `schematics-agent-infrastructure` workspace to provision the agent infrastructure. This can take up to 45 - 90 minutes to provision all the resources.  
5. View the **Jobs** logs and **Resources** page to monitor the resources are provisioned successfully and verify the workspace status is now `ACTIVE`.

    Record the `cluster_id` and `logdna_name` from the `Outputs:` section of the Jobs log. This information is used when deploying the agent. If the job fails and you do not observe the `cluster_id` details in the Jobs log, ensure you have the IAM permissions to create `VPC Infrastructure`, and `Kubernetes cluster` services. Then, click **Apply plan** to redeploy the agent infrastructure. 
    {: important}

### Expected outcome
{: #agents-setup-infra-output}

Follow the steps to view the Agent infrastructure workspace setup.

1. Navigate to the [Resources list](https://cloud.ibm.com/resources/){: external} page.
2. Verify the following resources are provisioned from the resource list page.
    - **VPC > Search** `<agent_prefix>-vpc` the status as **Available**.
    - **Services and Software** > `<agent_prefix>-logdna` the status as **Active**.
    - **Clusters** > `<agent_prefix>-iks` the status as **Normal**.
   
    Optionally, you can search the provisioned resources with the user tag you specified in the [Resources list](https://cloud.ibm.com/resources/){: external} page.
    {: note}


## Next steps
{: #nextsteps-agent-infra}

You have completed the {{site.data.keyword.bpshort}} agent infrastructure set up.
- Now, you need to [Deploy your Agent](/docs/schematics?topic=schematics-deploy-agent-overview) 


