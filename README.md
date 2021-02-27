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

# Todo

- Read config from file at runtime
- Read Environment Variables in Angular(???), Nginx?, Node?, any other options?

https://kubernetes.io/docs/concepts/configuration/configmap/#using-configmaps
