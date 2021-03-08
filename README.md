# Dockerizing Angular App using Docker Multi-stage build

TODO: a
- Build AppService /w APP_INITIALIZER
[https://medium.com/bb-tutorials-and-thoughts/angular-how-to-read-environment-info-at-runtime-for-ci-cd-9a788478aa9b](https://medium.com/bb-tutorials-and-thoughts/angular-how-to-read-environment-info-at-runtime-for-ci-cd-9a788478aa9b)

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 10.1.4.

## Docker + Node(12.18-alpine) + Angular(10.1.7) + Nginx(1.19.6-alpine)

### To build

- Default to Production
    ```
    docker build -t dockerangularstarter:production .
    ```

- To specific environment by setting configuration: e.g. staging, dev
    ```
    docker build -t dockerangularstarter:staging --build-arg configuration=staging .
    ```
    ```
    docker build -t dockerangularstarter:dev --build-arg configuration=dev .
    ```
- Learn about using [--build-arg](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg)  for build time variables

### To run

  ```
  docker run --rm -p 8080:80 dockerangularstarter:production
  ```
  ```
  docker run --rm -p 8080:80 dockerangularstarter:staging
  ```
  ```
  docker run --rm -p 8080:80 dockerangularstarter:dev
  ```

# Deploy to Azure Kubernetes Service /w public IP - AKS

- Create AKS Cluster, wire to ACR (~/.my-config/snippets)
- Docker build and push to ACR (~/.my-config/snippets)
- Open deployment.yml, change containers -> image to match the one in ACR
- Run `kubectl apply -f deployment.yml`

# Azure DevOps Pipeline
### 2 Pipelines, 2 Clusters, 1 Image, n tags, 2 Branches, 2 pipeline yml, 2 service.yml, 2 ConfigMap k/v pairs, 2 deployment.yml, 2 Deployment/Pod env k/v pairs
- DevOps Portal - 2 pipelines
  - master
    - image name (for docker build and the rest): default to project name. Optionally append the branch name to differentiate master/stage images.
    - rename azure-pipleline.yml to `master-pipeline.yml`
    - make sure master-pipeline.yml trigger to master 
    - save to master branch
    - rename the pipeline to `MyRepo-master`
  - stage
    - image name (for docker build and the rest): default to project name. Optionally append the branch name to differentiate master/stage images.
    - rename azure-pipleline.yml to `stage-pipeline.yml`
    - ***** edit stage-pipeline.yml `trigger` to `stage` ********
    - save to new branch `stage` off master
    - rename the pipeline to `MyRepo-stage`
  - Pre Deployment Approval
    - Environment tab
      - Approvals and Checks

- Ymls Updates
  - master
    - master-pipeline.yml
      - replace original tag -> tag: '$(Build.SourceBranchName)-$(Build.BuildId)'
    - manifests folder
      - service.yml
        - TODO: update `ConfigMap` k/v pairs
      - deployment.yml
        - TODO: update Deployment/Pod `env` k/v pairs
        - TODO: update image name? depends you want both master and stage using the same image name but differentiated only by tag (BuildID?)

  - stage
    - stage-pipeline.yml
      - replace original tag -> tag: '$(Build.SourceBranchName)-$(Build.BuildId)'
    - manifests folder
      - service.yml
        - TODO: update `ConfigMap` k/v data
      - deployment.yml
        - TODO: update Deployment/Pod `env` k/v data
        - TODO: update image name? depends you want both master and stage using the same image name but differentiated only by tag (BuildID?)



# Todo



