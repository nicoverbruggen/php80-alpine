# php80-alpine

## Why Alpine?

Using Alpine results in a much smaller Docker image!

## Quick start

To build: `docker build .`
To build and tag: `docker build -t tagname .`
To run and get interactive terminal: `docker run -it tagname sh`

To build for x86 specifically on M1: `docker buildx build . --platform linux/amd64 -t nicoverbruggen/php80-alpine`. (You could then push that to Docker Hub if you need x86 support.)

## What is this?

This is a custom build based on PHP 8.0's alpine docker image, with changes to make Laravel back-end testing easily possible.

## Where can I find it?

You can find the image on Docker Hub here: https://hub.docker.com/r/nicoverbruggen/php80-alpine.

## GitLab CI

For example, if you are running GitLab, you can use `.gitlab-ci` on your custom GitLab instance:

```
image: nicoverbruggen/php80-alpine:latest

cache:
  paths:
  - vendor/
  - node_modules/

tests:
  script:
  - curl -sS https://getcomposer.org/installer | php
  - php composer.phar install
  - npm install
  - npm run dev
  - vendor/bin/phpunit -v --configuration phpunit.ci.xml --coverage-text --colors=never
  after_script:
  - cat storage/logs/laravel.log 2>/dev/null
```

This will allow automatic tests of your application to occur.

A few notes:

- Front-end testing w/ Laravel Dusk is not supported in this version.
- This container ships with `npm` (NOT `yarn`!).

## How can I build this myself?

Use the Dockerfile, customize it as desired and build it!

    docker build -t nicoverbruggen/php80-alpine . && docker push nicoverbruggen/php80-alpine

If you want to tag the current version (let's say... `1.0`) based on the latest version you just pushed:

    docker image tag nicoverbruggen/php80-alpine:latest nicoverbruggen/php80:1.0
    docker push nicoverbruggen/php80-alpine:1.0

Anyone can run it afterwards:

    docker run nicoverbruggen/php80-alpine

You can also attach to the container with shell:

    docker run -it nicoverbruggen/php80-alpine sh
