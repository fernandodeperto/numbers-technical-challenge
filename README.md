# numbers-technical-challenge
Technical challenge that is part of an interview process

## TODOs
- Improve Helmfile with some default environment variables
- Add Velero to the cluster

## Pre-requisites
- [X] Deploy the resources on Azure
- [ ] Use Azure DevOps
  - As the code was already being hosted on Github, Github Actions seemed like a simpler choice. Since I have no experience with either, Most of my experience, and where I have the most skill, is on Gitlab, and some Jenkins and other small CI/CD projects.
- [X] Scripting language
  - No scripting was necessary. Automation is done via Github Actions for the first task, Terraform is used for all the cloud resources, and Helmfile for the Kubernetes deployments.
  - With some extra time, I would have also added the deployment of the AKS clsuter to the Github Actions pipeline
- [ ] Use ARM Templates for deploying the cloud resources
  - As I already have years of experience with Terraform, I used it for deploying the resources to keep the total time used on the tasks in check.

## Objectives
### Task 1
- [X] Deploy WebFarm of 2 nodes (VM, Container, Application Service, etc.)
    - [Terraform module](terraform/modules/azure-webfarm)
    - [Test environment deployment](terraform/environments/numbers-test/azure-webfarm)
- [X] Scheduled based auto-scaling
    - [Code](terraform/modules/azure-webfarm/main.tf#L8)
- [X] Nodes must be behind a Firewall/WAF
    - Nodes are provisioned by a [scale set](terraform/modules/azure-webfarm/main.tf#L49), and are connected to a [security group](terraform/modules/azure-webfarm/securitygroup.tf) that only allows incoming connections on port 8000, used by the app. Furthermore, a [load balancer](terraform/modules/azure-webfarm/loadbalancer.tf) is provisioned, with a [public IP](terraform/modules/azure-webfarm/network.tf#L18) and backend configuration that leads to the scale set.
- [X] Deploy a sample Hello app
    - A small [Flask App](magnusapi) was created for this task, called MagnusAPI, with support for databases, including migrations.
    - To run it on the instance, Supervisord is used
    - It supports a [health endpoint](http://numbers-test-webfarm.apilabs.xyz/health), a [GET endpoint](http://numbers-test-webfarm.apilabs.xyz/item) that shows all items in the database, and a [POST endpoint](http://numbers-test-webfarm.apilabs.xyz/item) that can be used to add items to the database. An example can be seen on [CURL command to add items](#CURL-command-to-add-items).
    - The test environment is available at http://numbers-test-webfarm.apilabs.xyz


## Changelog

### [Unreleased]
#### Added
#### Changed
#### Removed
### [0.8.0]
#### Added
- [Postfacto Helm chart](helmfile/charts/postfacto) and [Helmfile config](helmfile/helmfiles/postfacto)
- [Posfacto deployment](https://postfacto-test.apilabs.xyz)
- Link for [example retro](https://postfacto-test.apilabs.xyz/retros/infra-1/join/1eyjJfzWAfTVXhKguwd4r5O0U0dnHH1t)
#### Changed
- Increased AKS node count
#### Removed
### [0.7.0]
#### Added
- [AKS Terraform module](terraform/modules/azure-aks)
- [AKS test environment](terraform/environments/numbers-test/azure-aks)
- [Helmfile config files](helmfile)
- [Helm chart for creating a secret in the cluster](helmfile/charts/secret)
- [Helm chart for creating a certificate issuer in the cluster](helmfile/charts/issuer)
- [Helm chart for testing everything](helmfile/charts/nginx)
#### Changed
#### Removed
### [0.6.0]
#### Added
#### Changed
- Use the SHA of the commit instead of tag to deploy with Terraform
- Scale set VMs no longer have SSH access enabled
#### Removed
### [0.5.1]
#### Added
#### Changed
- Updated Github actions to apply Webfarm Terraform code
#### Removed
### [0.5.0]
#### Added
- MagnusAPI updated to new version using Flask
- Random string on Terraform that is used as Flask secret key
- Support for upgrading the database in the custom data script
#### Changed
#### Removed
### [0.4.0]
#### Added
- [Terraform DNS zone module](terraform/modules/azure-zone)
- [New production environment containing the DNS zone deployment](terraform/environments/numbers-prod/azure-zone)
#### Changed
- Fixed small issues with the Webfarm module's custom data script
- Added support for creating an A record on the Webfarm module
- Changed default magnusapi response so it also prints the current version
#### Removed
### [0.3.0]
#### Added
- [MagnusAPI early version code](magnusapi)
- Terraform custom data script that installs supervisord and loads the API
#### Changed
- Port used for communication changed from 80 to 8000, used by uvicorn
#### Removed
### [0.2.0]
#### Added
- Terraform state lock files
- [Webfarm Terraform module](terraform/modules/azure-webfarm)
#### Changed
#### Removed
### [0.1.0]
#### Added
- Repository, README file, branch and pull request
- [Git-crypt configuration](.gitattributes)
- Gitignore
- [Pre-commit configuration](.pre-commit-config.yaml)
- [Terraform bootstrap remote state module](terraform/modules/azure-remote-state)
- [Terraform service principal module](terraform/modules/azure-service-principal)
- [Github actions file](.github/workflows/deploy-magnusapi-test.yaml)
#### Changed
#### Removed

## Future steps and limitations
- Move PostgreSQL database to a separate module
- Move resource groups to a separate module

# Appendix
## CURL command to add items
```bash
curl --location --request POST 'numbers-test-webfarm.apilabs.xyz/item' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "a new item"
}'
```

## References
[1]: https://github.com/hashicorp/terraform-provider-azurerm/issues/8534
