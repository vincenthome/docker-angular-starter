# Dockerizing Angular App using Docker Multi-stage build

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 10.1.4.

## Docker + Node(12.18-alpine) + Angular(10.1.7) + Nginx(1.19.6-alpine)

### To build

- Default to Production
    ```
    docker build -t dockerangularstarter:prod .
    ```

- To specific environment by setting configuration: e.g. staging
    ```
    docker build -t dockerangularstarter:staging --build-arg configuration=staging .
    ```

### To run

  ```
  docker run --rm -p 8080:80 dockerangularstarter:prod
  ```

  ```
  docker run --rm -p 8080:80 dockerangularstarter:staging
  ```
