**Build Infrastructure - Terraform Docker Example**

- What is IaC and Terraform
- https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli

- Follow the instruction to provision docker-nginx
https://developer.hashicorp.com/terraform/tutorials/docker-get-started/docker-build

**Change Infrastructure**

In the last tutorial, you created your first infrastructure with Terraform: a single Docker container. In this tutorial, you will modify that resource, and learn how to apply changes to your Terraform projects.

Infrastructure is continuously evolving, and Terraform helps you manage that change. As you change Terraform configurations, Terraform builds an execution plan that only modifies what is necessary to reach your desired state.

When using Terraform in production, we recommend that you use a version control system to manage your configuration files, and store your state in a remote backend such as Terraform Cloud or Terraform Enterprise.

##Prerequisites

This tutorial assumes that you are continuing from the previous tutorials. If not, follow the steps below before continuing.

Install the Terraform CLI (0.15+), and the Docker CLI (configured with a default profile), as described in the install tutorial.

Create a directory named learn-terraform-docker-container and paste the following configuration into a file named main.tf.


terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}


##Initialize the configuration.

$ terraform init

Apply the configuration. Respond to the confirmation prompt with a yes.

$ terraform apply

Once you have successfully applied the configuration, you can continue with the rest of this tutorial.

Update configuration

Now update the external port number of your container. Change the docker_container.nginx resource under the provider block in main.tf by replacing the ports.external value of 8000 with 8080

Tip: The below snippet is formatted as a diff to give you context about which parts of your configuration you need to change. Replace the content displayed in red with the content displayed in green, leaving out the leading + and - signs.]
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  hostname = "learn-terraform-docker"
  ports {
    internal = 80
-   external = 8000
+   external = 8080
  }
}
This update changes the port number your container uses to serve your nginx server. The Docker provider knows that it cannot change the port of a container after it has been created, so Terraform will destroy the old container and create a new one.

Apply Changes

After changing the configuration, run terraform apply again to see how Terraform will apply this change to the existing resources.

$ terraform apply
docker_image.nginx: Refreshing state... [id=sha256:d1a364dc548d5357f0da3268c888e1971bbdb957ee3f028fe7194f1d61c6fdeenginx:latest]
docker_container.nginx: Refreshing state... [id=5896c6cb7ae654503c36562472b573da8f49057fd466927be2870453a3b93e51]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # docker_container.nginx must be replaced
-/+ resource "docker_container" "nginx" {
##...
      ~ ports {
          ~ external = 8000 -> 8080 # forces replacement
            # (3 unchanged attributes hidden)
        }
    }

Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

Copy
The prefix -/+ means that Terraform will destroy and recreate the resource, rather than updating it in-place. Terraform can update some attributes in-place (indicated with the ~ prefix), but changing the port for a Docker container requires recreating it. Terraform handles these details for you, and the execution plan displays what Terraform will do.

Additionally, the execution plan shows that the port change is what forces Terraform to replace the container. Using this information, you can adjust your changes to to avoid destructive updates if necessary.

Once again, Terraform prompts for approval of the execution plan before proceeding. Answer yes to execute the planned steps.

docker_container.nginx: Destroying... [id=5896c6cb7ae654503c36562472b573da8f49057fd466927be2870453a3b93e51]
docker_container.nginx: Destruction complete after 1s
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=b2140f8c6aa79f62c8ac3c3d792f2044bcca8d5a0a08a4598ead1ade7aab7e6e]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
As indicated by the execution plan, Terraform first destroyed the existing container and then created a new one in its place. You can use terraform show again to have Terraform print out the new values associated with this container.

# Destroy Infrastructure

2min
Terraform
Terraform

Add bookmark
You have now created and updated a Docker container on your machine with Terraform. In this tutorial, you will use Terraform to destroy this infrastructure.

Once you no longer need infrastructure, you may want to destroy it to reduce your security exposure, costs, or resource overhead. For example, you may remove a production environment from service, or manage short-lived environments like build or testing systems. In addition to building and modifying infrastructure, Terraform can destroy or recreate the infrastructure it manages.

**Destroy**

The terraform destroy command terminates resources managed by your Terraform project. This command is the inverse of terraform apply in that it terminates all the resources specified in your Terraform state. It does not destroy resources running elsewhere that are not managed by the current Terraform project.

Destroy the resources you created.

$ terraform destroy
docker_image.nginx: Refreshing state... [id=sha256:d1a364dc548d5357f0da3268c888e1971bbdb957ee3f028fe7194f1d61c6fdeenginx:latest]
docker_container.nginx: Refreshing state... [id=b2140f8c6aa79f62c8ac3c3d792f2044bcca8d5a0a08a4598ead1ade7aab7e6e]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # docker_container.nginx will be destroyed
  - resource "docker_container" "nginx" {
##...

  # docker_image.nginx will be destroyed
  - resource "docker_image" "nginx" {
      - id           = "sha256:d1a364dc548d5357f0da3268c888e1971bbdb957ee3f028fe7194f1d61c6fdeenginx:latest" -> null
      - keep_locally = false -> null
      - latest       = "sha256:d1a364dc548d5357f0da3268c888e1971bbdb957ee3f028fe7194f1d61c6fdee" -> null
      - name         = "nginx:latest" -> null
    }

Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value:
Copy
The - prefix indicates that the container will be destroyed. As with apply, Terraform shows its execution plan and waits for approval before making any changes.

Answer yes to execute this plan and destroy the infrastructure.

  Enter a value: yes

docker_container.nginx: Destroying... [id=b2140f8c6aa79f62c8ac3c3d792f2044bcca8d5a0a08a4598ead1ade7aab7e6e]
docker_container.nginx: Destruction complete after 2s
docker_image.nginx: Destroying... [id=sha256:d1a364dc548d5357f0da3268c888e1971bbdb957ee3f028fe7194f1d61c6fdeenginx:latest]
docker_image.nginx: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.
Just like with apply, Terraform determines the order to destroy your resources. In this case, Terraform identified a single container with no other dependencies, so it destroyed the container. In more complicated cases with multiple resources, Terraform will destroy them in a suitable order to respect dependencies.



