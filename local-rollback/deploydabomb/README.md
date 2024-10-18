# deploydabomb

This Ansible role automates the build, push, and deployment of Docker containers for an application. It is designed to manage Docker images across multiple systems: a build system, Docker registry, and deployment systems. The role ensures that only the latest `n` Docker images are kept on all systems and allows deployment rollbacks by specifying a version to deploy.

## Supported Features
### 1. Docker Image Build and Push
- Build Docker images locally on the build system.
- Tag Docker images with either a specified version or an auto-generated timestamp.
- Push the images to Docker Hub (or other Docker registries).
### 2.Versioning and Rollbacks
- Deploy a specific version of the Docker image by specifying the deploy_version variable.
- Skip building the image if deploy_version is provided, using the pre-built image instead.

Requirements
------------

Already have `dockerfile` for the codebase.

Role Variables
--------------

The following variables can be customized in defaults/main.yml or passed during playbook execution:
| Variable | Default Value | Description |
| -------- | ------------- | ----------- |
| app_dir  | `../../code/deploy_da_bomb` | Path to the application code directory for Docker build. |
| docker_image_name | `deploy-da-bomb` | Name of the Docker image to build, push, and deploy. |
| app_container_name | `deploy-da-bomb` | Name of the Docker container to run on deployment systems. |
| dockerhub_username | `mrsalehi1380` | Docker Hub username for pushing the Docker image. |
| dockerhub_token | `XXX` | Docker Hub access token for pushing the Docker image. |
| deploy_version | `none` | Version of the Docker image to deploy. If provided, the role will skip building the image and use the pre-built image instead. |

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
