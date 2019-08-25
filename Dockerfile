FROM node:10-alpine
ADD . ./app
WORKDIR /app

RUN apk add --no-cache curl
RUN apk add --no-cache wget
RUN apk add --no-cache bash

RUN export TRAVIS_REPO_SLUG=${TRAVIS_REPO_SLUG}
RUN export TRAVIS_PULL_REQUEST=${TRAVIS_PULL_REQUEST}
RUN export TRAVIS_TAG=${TRAVIS_TAG}
RUN export TRAVIS_BRANCH=${TRAVIS_BRANCH}
RUN export GITHUB_API_TOKEN=${GITHUB_API_TOKEN}
RUN export SURGE_TOKEN=${SURGE_TOKEN}
RUN export SURGE_LOGIN=${SURGE_LOGIN}

RUN chmod +x .docker/scripts/install_hugo.sh
RUN chmod +x .docker/scripts/build.sh
RUN chmod +x .docker/scripts/deploy.sh

RUN .docker/scripts/install_hugo.sh
RUN .docker/scripts/build.sh

ENTRYPOINT .docker/scripts/deploy.sh; /bin/bash
