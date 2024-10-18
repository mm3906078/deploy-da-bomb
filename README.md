# deploy-da-bomb

## Project Structure
```
deploy-da-bomb
│   README.md
│   code/deploy_da_bomb # Main codebase
│   local-rollback/ # Save the old builds in the host and docker registry
│   previous-commit-rollback/ # Save the old builds in the commits and GitLab container registry
```

## How to use
Each method of rollback has its own dedicated `README.md` file within its respective directory.
### 1. Local Rollback
This method uses `molecule` for testing the Ansible role. You need an unrestricted internet connection to run the test. Here's how to get started:
```bash
cd local-rollback/deploydabomb
molecule converge
```
After running the above command, the role will be deployed, and you'll see the results in the console.

Example output:
```
(.venv) ➜  deploydabomb git:(main) ✗ molecule converge
WARNING  Driver docker does not provide a schema.
INFO     default scenario test matrix: dependency, create, prepare, converge
INFO     Performing prerun with role_name_check=0...
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > create
INFO     Sanity checks: 'docker'

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'cgroupns_mode': 'host', 'command': '', 'image': 'geerlingguy/docker-debian11-ansible:latest', 'name': 'deploy-da-bomb', 'pre_build_image': True, 'privileged': True, 'volumes': ['/sys:/sys:ro', '/var/lib/containerd']})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'cgroupns_mode': 'host', 'command': '', 'image': 'geerlingguy/docker-debian11-ansible:latest', 'name': 'deploy-da-bomb', 'pre_build_image': True, 'privileged': True, 'volumes': ['/sys:/sys:ro', '/var/lib/containerd']})
skipping: [localhost]

TASK [Synchronization the context] *********************************************
skipping: [localhost] => (item={'cgroupns_mode': 'host', 'command': '', 'image': 'geerlingguy/docker-debian11-ansible:latest', 'name': 'deploy-da-bomb', 'pre_build_image': True, 'privileged': True, 'volumes': ['/sys:/sys:ro', '/var/lib/containerd']})
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'false_condition': 'not item.pre_build_image | default(false)', 'item': {'cgroupns_mode': 'host', 'command': '', 'image': 'geerlingguy/docker-debian11-ansible:latest', 'name': 'deploy-da-bomb', 'pre_build_image': True, 'privileged': True, 'volumes': ['/sys:/sys:ro', '/var/lib/containerd']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/geerlingguy/docker-debian11-ansible:latest) 
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'cgroupns_mode': 'host', 'command': '', 'image': 'geerlingguy/docker-debian11-ansible:latest', 'name': 'deploy-da-bomb', 'pre_build_image': True, 'privileged': True, 'volumes': ['/sys:/sys:ro', '/var/lib/containerd']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=deploy-da-bomb)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j327746641507.385893', 'results_file': '/home/mohammadreza/.ansible_async/j327746641507.385893', 'changed': True, 'item': {'cgroupns_mode': 'host', 'command': '', 'image': 'geerlingguy/docker-debian11-ansible:latest', 'name': 'deploy-da-bomb', 'pre_build_image': True, 'privileged': True, 'volumes': ['/sys:/sys:ro', '/var/lib/containerd']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [deploy-da-bomb]

TASK [Update apt and Install pakages] ******************************************
changed: [deploy-da-bomb]

TASK [Install required python packages] ****************************************
changed: [deploy-da-bomb]

TASK [Make sure docker service started] ****************************************
changed: [deploy-da-bomb]

TASK [deploydabomb : Determine if we need to build the image] ******************
ok: [deploy-da-bomb -> localhost]

TASK [deploydabomb : Build the app] ********************************************
included: /home/mohammadreza/deploy-da-bomb/local-rollback/deploydabomb/tasks/build.yml for deploy-da-bomb

TASK [deploydabomb : Set build_version] ****************************************
ok: [deploy-da-bomb -> localhost]

TASK [deploydabomb : Build the application locally] ****************************
changed: [deploy-da-bomb -> localhost]

TASK [deploydabomb : Log in to Docker Hub] *************************************
ok: [deploy-da-bomb -> localhost]

TASK [deploydabomb : Push the image to Docker Hub] *****************************
changed: [deploy-da-bomb -> localhost]

TASK [deploydabomb : Deploy the app] *******************************************
included: /home/mohammadreza/deploy-da-bomb/local-rollback/deploydabomb/tasks/deploy.yml for deploy-da-bomb

TASK [deploydabomb : Set deployment version] ***********************************
ok: [deploy-da-bomb]

TASK [deploydabomb : Log in to Docker Hub] *************************************
changed: [deploy-da-bomb]

TASK [deploydabomb : Pull the Docker image on the target server] ***************
changed: [deploy-da-bomb]

TASK [deploydabomb : Get current image ID of the running container] ************
ok: [deploy-da-bomb]

TASK [deploydabomb : Set current image ID fact] ********************************
skipping: [deploy-da-bomb]

TASK [deploydabomb : Get new image ID] *****************************************
ok: [deploy-da-bomb]

TASK [deploydabomb : Determine if container needs to be updated] ***************
ok: [deploy-da-bomb]

TASK [deploydabomb : Restart container if needed] ******************************
changed: [deploy-da-bomb] => {
    "msg": "Container needs to be updated."
}

TASK [deploydabomb : No update needed] *****************************************
skipping: [deploy-da-bomb]

TASK [deploydabomb : Flush handlers.] ******************************************

RUNNING HANDLER [deploydabomb : Stop the running container] ********************
ok: [deploy-da-bomb]

RUNNING HANDLER [deploydabomb : Deploy the new Docker container] ***************
changed: [deploy-da-bomb]

PLAY RECAP *********************************************************************
deploy-da-bomb             : ok=20   changed=9    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```
To verify the deployment, you can log into the container and check the logs for the running application:
```bash
molecule login
docker logs deploy-da-bomb
```
Expected output:
```
(.venv) ➜  deploydabomb git:(main) ✗ molecule login   
WARNING  Driver docker does not provide a schema.
INFO     Running default > login
root@deploy-da-bomb:/# docker logs deploy-da-bomb
Deploying the bomb! Starting time display loop...
Current time: 12:48:22.386343
```
If you run the deployment again without any code changes, the container will not redeploy. However, if you modify the code, the image ID will change, causing the container to redeploy.

For rollback testing, first, find the old image ID, which can be retrieved from the [Docker Hub registry](https://hub.docker.com/repository/docker/mrsalehi1380/deploy-da-bomb/tags) or from the container logs. Then, run the rollback command as follows:
```bash
molecule converge -- --extra-vars "rollback_image_id=20241018124959"
```


### 2. Previous Commit Rollback
To use this method, simply add the `.gitlab-ci.yml` and `.deployment-ci-configurator` files to your project, and configure the necessary variables in the `CI/CD` settings of your GitLab project. More details are available in the `README.md` file in the `previous-commit-rollback/` directory.
