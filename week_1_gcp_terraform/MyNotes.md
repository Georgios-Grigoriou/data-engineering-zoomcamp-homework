**Infrastructure as Code**

Source: https://developer.hashicorp.com/terraform/tutorials/gcp-get-started, https://www.terraform.io/


Infrastructure as code (IaC) tools allow you to manage infrastructure with configuration files rather than through a graphical user interface. 

IaC allows you to build, change, and manage your infrastructure in a safe, consistent, and repeatable way by defining resource configurations that you can version, reuse, and share.

**What is Terraform?**

Terraform is HashiCorp's infrastructure as code tool. 

It lets you define resources and infrastructure in **human-readable, declarative configuration files**, and manages your infrastructure's lifecycle. 

**What are the advantages of using Terraform?**

Using Terraform has several advantages over manually managing your infrastructure:

- Terraform can manage infrastructure on multiple cloud platforms.
- The human-readable configuration language helps you write infrastructure code quickly.
- **Terraform's state** allows you to track resource changes throughout your deployments.
- Remote Backend such as Terraform Cloud allow you and your team to commit your configurations to version control to safely collaborate on infrastructure.

![image](https://user-images.githubusercontent.com/65050959/215259889-7c403652-4de9-4b7d-824d-db93a4775e83.png)


**Manage any infrastructure**
**Terraform plugins called providers let Terraform interact with cloud platforms and other services via their application programming interfaces (APIs)**. HashiCorp and the Terraform community have written over 1,000 providers to manage resources on Amazon Web Services (AWS), Azure, Google Cloud Platform (GCP), Kubernetes, Helm, GitHub, Splunk, and DataDog, just to name a few. Find providers for many of the platforms and services you already use in the Terraform Registry. If you don't find the provider you're looking for, you can write your own.

![image](https://user-images.githubusercontent.com/65050959/215260089-04e8b354-2980-417c-bee9-cda9d75ebd92.png)


**Standardize your deployment workflow**
Providers define individual units of infrastructure, for example compute instances or private networks, as resources. You can compose resources from different providers into reusable Terraform configurations called modules, and manage them with a consistent language and workflow.

![image](https://user-images.githubusercontent.com/65050959/215260139-e94df984-b84c-4c82-b2a1-875ebaf958e4.png)

**Terraform's configuration language is declarative, meaning that it describes the desired end-state for your infrastructure, in contrast to procedural programming languages that require step-by-step instructions to perform tasks.** Terraform providers automatically calculate dependencies between resources to create or destroy them in the correct order.

![image](https://user-images.githubusercontent.com/65050959/215260164-afca3be0-d49d-4642-94e4-c5f4ed555d6b.png)

**Terraform deployment workflow**

To deploy infrastructure with Terraform:

**Scope** - Identify the infrastructure for your project.
**Author** - Write the configuration for your infrastructure.
**Initialize** - Install the plugins Terraform needs to manage the infrastructure.
**Plan** - Preview the changes Terraform will make to match your configuration.
**Apply** - Make the planned changes.

**Track your infrastructure**
**Terraform keeps track of your real infrastructure in a state file, which acts as a source of truth for your environment.** Terraform uses the state file to determine the changes to make to your infrastructure so that it will match your configuration.

**Collaborate**
Terraform allows you to collaborate on your infrastructure with its remote state backends. When you use Terraform Cloud (free for up to five users), you can securely share your state with your teammates, provide a stable environment for Terraform to run in, and prevent race conditions when multiple people make configuration changes at once.

You can also connect Terraform Cloud to version control systems (VCSs) like GitHub, GitLab, and others, allowing it to automatically propose infrastructure changes when you commit configuration changes to VCS. This lets you manage changes to your infrastructure through version control, as you would with application code.


**Install Terraform**

Follow the instruction here:
https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli

**Quick start tutorial**

Now that you've installed Terraform, you can provision an NGINX server[https://www.nginx.com/resources/glossary/nginx/] in less than a minute using Docker on Mac, Windows, or Linux. You can also follow the rest of this tutorial in your web browser.

Click on the tab(s) below relevant to your operating system.

After you install Terraform and Docker on your local machine, start Docker Desktop.

  open -a Docker

Create a directory 
mkdir learn-terraform-docker-container

Navigate into the working directory.
cd learn-terraform-docker-container


In the working directory, create a file called main.tf and paste the following Terraform configuration into it from the file below:

  https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli

Initialize the project, which downloads a plugin called a provider that lets Terraform interact with Docker.
   -terraform init

Provision the NGINX server container with apply. When Terraform asks you to confirm type yes and press ENTER.
   -terraform apply

Verify the existence of the NGINX container by visiting localhost:8000 in your web browser or running docker ps to see the container.
   -docker ps

To stop the container, run terraform destroy.
   -terraform destroy

### Run Google Cloud Platform
https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build

With Terraform installed, you are ready to create some infrastructure.

You will build infrastructure on Google Cloud Platform (GCP) for this tutorial, but Terraform can manage a wide variety of resources using providers. You can find more examples in the use cases section.

As you follow these tutorials, you will use Terraform to provision, update, and destroy a simple set of infrastructure using the sample configuration provided. The sample configuration provisions a network and a Linux virtual machine. You will also learn about remote backends, input and output variables, and how to configure resource dependencies. These are the building blocks for more complex configurations.


Set up GCP

After creating your GCP account, create or modify the following resources to enable Terraform to provision your infrastructure:

**A GCP Project:** GCP organizes resources into projects. Create one now in the GCP console and make note of the project ID. You can see a list of your projects in the cloud resource manager.

**Google Compute Engine:** Enable Google Compute Engine for your project in the GCP console. Make sure to select the project you are using to follow this tutorial and click the "Enable" button.

**A GCP service account key:** Create a service account key to enable Terraform to access your GCP account. When creating the key, use the following settings:

- Select the project you created in the previous step.
- Click "Create Service Account".
- Give it any name you like and click "Create".
- For the Role, choose "Project -> Editor", then click "Continue".
- Skip granting additional users access, and click "Done".
- After you create your service account, download your service account key.
- Select your service account from the list.
- Select the "Keys" tab.
- In the drop down menu, select "Create new key".
- Leave the "Key Type" as JSON.
- Click "Create" to create the key and save the key file to your system.

**Write configuration**

**The set of files used to describe infrastructure in Terraform is known as a Terraform configuration**. You will now write your first configuration to create a network.

Each Terraform configuration must be in its own working directory. Create a directory for your configuration.

**Terraform Block**

The terraform {} block contains Terraform settings, including the required providers Terraform will use to provision your infrastructure. For each provider, the source attribute defines an optional hostname, a namespace, and the provider type. Terraform installs providers from the Terraform Registry by default. In this example configuration, the google provider's source is defined as hashicorp/google, which is shorthand for registry.terraform.io/hashicorp/google.

You can also define a version constraint for each provider in the required_providers block. The version attribute is optional, but we recommend using it to enforce the provider version. Without it, Terraform will always use the latest version of the provider, which may introduce breaking changes.

To learn more, reference the provider source documentation.

Providers

The provider block configures the specified provider, in this case google. A provider is a plugin that Terraform uses to create and manage your resources. You can define multiple provider blocks in a Terraform configuration to manage resources from different providers.

**Resource**

Use resource blocks to define components of your infrastructure. A resource might be a physical component such as a server, or it can be a logical resource such as a Heroku application.

Resource blocks have two strings before the block: the resource type and the resource name. In this example, the resource type is google_compute_network and the name is vpc_network. The prefix of the type maps to the name of the provider. In the example configuration, Terraform manages the google_compute_network resource with the google provider. Together, the resource type and resource name form a unique ID for the resource. For example, the ID for your network is google_compute_network.vpc_network.

Resource blocks contain arguments which you use to configure the resource. Arguments can include things like machine sizes, disk image names, or VPC IDs. The Terraform Registry GCP documentation page documents the required and optional arguments for each GCP resource. For example, you can read the google_compute_network documentation to view the resource's supported arguments and available attributes.

The GCP provider documents supported resources, including google_compute_network and its supported arguments.

**Initialize the directory**

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init. This step downloads the providers defined in the configuration.

Initialize the directory.

##**Terraform Block**
- The terraform {} block contains Terraform settings, including the required providers Terraform will use to provision your infrastructure. 
- For each provider, the source attribute defines an optional hostname, a namespace, and the provider type. 
- Terraform installs providers from the Terraform Registry by default. In this example configuration, the google provider's source is defined as hashicorp/google, which is shorthand for registry.terraform.io/hashicorp/google.
- You can also define a version constraint for each provider in the required_providers block. The version attribute is optional, but we recommend using it to enforce the provider version. Without it, Terraform will always use the latest version of the provider, which may introduce breaking changes.

##**Providers**
- The provider block configures the specified provider, in this case google. 
- A provider is a plugin that Terraform uses to create and manage your resources. 
- You can define multiple provider blocks in a Terraform configuration to manage resources from different providers.

##**Resource**
- Use resource blocks to define components of your infrastructure. A resource might be a physical component such as a server, or it can be a logical resource such as a Heroku application.
- Resource blocks have two strings before the block: the resource type and the resource name. 

*In this example, the resource type is google_compute_network and the name is vpc_network. The prefix of the type maps to the name of the provider. In the example configuration, Terraform manages the google_compute_network resource with the google provider. Together, the resource type and resource name form a unique ID for the resource. For example, the ID for your network is google_compute_network.vpc_network.
- Resource blocks contain arguments which you use to configure the resource. Arguments can include things like machine sizes, disk image names, or VPC IDs. The Terraform Registry GCP documentation page documents the required and optional arguments for each GCP resource. For example, you can read the google_compute_network documentation to view the resource's supported arguments and available attributes. The GCP provider documents supported resources, including google_compute_network and its supported arguments.

### Terraform Commands
- **terraform init**:Initialize Directory
- **terraform apply**:Create infrastructure
- **terraform fmt**: Format configuration
- **terraform state**: Validate the configuration
- **terraform show**:Inspect the current state using t
- **terraform destroy**: Destroy Terraform Infrastructure


## Change Infrastructure
https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-change

In the previous tutorial, you created your first infrastructure with Terraform: a VPC network. In this tutorial, you will modify your configuration, and learn how to apply changes to your Terraform projects.

Infrastructure is continuously evolving, and Terraform was built to help manage resources over their lifecycle. When you update Terraform configurations, Terraform builds an execution plan that only modifies what is necessary to reach your desired state.

When using Terraform in production, we recommend that you use a version control system to manage your configuration files, and store your state in a remote backend such as Terraform Cloud or Terraform Enterprise.

## Create a new resource

You can create new resources by adding them to your Terraform configuration and running *terraform apply to provision them.

Add the following configuration for a Google compute instance resource to main.tf.

## Modify configuration

In addition to creating resources, Terraform can also make changes to those resources.

Add a tags argument to your vm_instance resource block.

The prefix ~ means that Terraform will update the resource in-place. You can apply this change now by responding yes, and Terraform will add the tags to your instance.

**Introduce destructive changes**

A destructive change is a change that requires the provider to replace the existing resource rather than updating it. This usually happens because the cloud provider does not support updating the resource in the way described by your configuration.

Changing the disk image of your instance is one example of a destructive change. Edit the boot_disk block inside the vm_instance resource in your configuration file to change the image parameter as follows.

*Tip: The below snippet is formatted as a diff to give you context about what in your configuration should change. Replace the content displayed in red with the content displayed in green (exclude the leading + and - signs).

This modification changes the boot disk from a Debian 11 image to Google's Container-Optimized OS.

Now run terraform apply again. Terraform will replace the instance because Google Cloud Platform does not support replacing the boot disk image on a running instance.

The prefix -/+ means that Terraform will destroy and recreate the resource, rather than updating it in-place. Terraform and the GCP provider handle these details for you, and the execution plan reports what Terraform will do.

Additionally, the execution plan shows that the disk image change is the modification that forced the instance replacement. Using this information, you can adjust your changes to possibly avoid destructive updates if they are not acceptable.

Once again, Terraform prompts for approval of the execution plan before proceeding. Answer yes to execute the planned steps.

As indicated by the execution plan, Terraform first destroyed the existing instance and then created a new one in its place. You can use terraform show again to see the new values associated with this instance.

**Destroy Infrastructure**

You have created and modified infrastructure using Terraform. You will now learn how to destroy your Terraform-managed infrastructure.

Once you no longer need infrastructure, you might want to destroy it to reduce your security exposure and costs. For example, you may remove a production environment from service, or manage short-lived environments like build or testing systems. In addition to building and modifying infrastructure, Terraform can destroy or recreate the resources it manages.

**Destroy**

The terraform destroy command terminates resources managed by your Terraform project. This command is the inverse of terraform apply in that it terminates all the resources specified in your Terraform state. It does not destroy resources running elsewhere that are not managed by the current Terraform project.

**Define Input Variables**

Tip: Terraform loads all files ending in .tf in the working directory, so you can name your configuration files however you choose. We recommend defining variables in their own file to make your configuration easier to organize and understand.


  variable "project" { }

  variable "credentials_file" { }

  variable "region" {
      default = "us-central1"
    }

variable "zone" {
  default = "us-central1-c"
}

This file defines four variables within your Terraform configuration. The project and credentials_file variables have an empty block: { }. The region and zone variables set defaults. If a default value is set, the variable is optional. Otherwise, the variable is required. If you run terraform plan now, Terraform will prompt you for the values for project and credentials_file.

You now have enough Terraform knowledge to create useful configurations, but the examples so far have used hard-coded values. Terraform configurations can include variables to make your configuration more dynamic and flexible.

**Define input variables**

Working in your learn-terraform-gcp directory, create a new file called variables.tf with the following variable definitions.
