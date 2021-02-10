### STAGE 1: Build ###
FROM node:12.18-alpine AS build
# ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
# npm ci include cache clean
RUN npm ci --only=production -silent
RUN npm i @angular/cli@10.1.6 -silent
# put ngcc in its own layer to avoid it being called on every ng build
RUN ./node_modules/.bin/ngcc
# RUN ./node_modules/.bin/ngcc --properties es2015 browser module main --create-ivy-entry-points
COPY . .
# DEFAULT configuration to production
ARG configuration=production
RUN npm run build -- --prod --configuration $configuration

### STAGE 2: Run ###
FROM nginx:1.19.6-alpine
## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /usr/src/app/dist/docker-angular-starter /usr/share/nginx/html
COPY nginx-custom.conf /etc/nginx/conf.d/default.conf

# Without this still works!
# CMD ["nginx", "-g", "daemon off;"]

# Reference
# https://github.com/Humadroid/Angular-Docker-Nginx-Multi-Stage-Builds

# To build - default production
# docker build -t dockerangularstarter:prod .
# docker build -t dockerangularstarter:staging --build-arg configuration=staging .
# docker build -t dockerangularstarter:dev --build-arg configuration=dev .

# To run
# docker run --rm -p 8080:80 dockerangularstarter:prod
# docker run --rm -p 8080:80 dockerangularstarter:staging
# docker run --rm -p 8080:80 dockerangularstarter:dev
