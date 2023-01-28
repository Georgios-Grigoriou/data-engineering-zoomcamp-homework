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
