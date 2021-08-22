# numbers-technical-challenge
Technical challenge that is part of an interview process

## TODOs

## Changelog

### [Unreleased]
#### Added
#### Changed
- Use the SHA of the commit instead of tag to deploy with Terraform
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
- Terraform DNS zone module
- New production environment containing the DNS zone deployment
#### Changed
- Fixed small issues with the Webfarm module's custom data script
- Added support for creating an A record on the Webfarm module
- Changed default magnusapi response so it also prints the current version
#### Removed
### [0.3.0]
#### Added
- MagnusAPI early version code
- Terraform custom data script that installs supervisord and loads the API
#### Changed
- Port used for communication changed from 80 to 8000, used by uvicorn
#### Removed
### [0.2.0]
#### Added
- Terraform state lock files
- Webfarm Terraform module
#### Changed
#### Removed
### [0.1.0]
#### Added
- Repository, README file, branch and pull request
- Git-crypt configuration
- Gitignore
- Pre-commit configuration
- Terraform bootstrap remote state module
- Terraform service principal module
- Github actions file
#### Changed
#### Removed

## References

[1]: https://github.com/hashicorp/terraform-provider-azurerm/issues/8534
