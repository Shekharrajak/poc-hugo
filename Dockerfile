FROM node:10-alpine
ADD . ./app
WORKDIR /app

RUN apk add --no-cache curl
RUN apk add --no-cache wget
RUN apk add --no-cache bash

ENV TRAVIS_REPO_SLUG "$TRAVIS_REPO_SLUG"
ENV TRAVIS_PULL_REQUEST "$TRAVIS_PULL_REQUEST"
ENV TRAVIS_TAG "$TRAVIS_TAG"
ENV TRAVIS_BRANCH "$TRAVIS_BRANCH"
ENV GITHUB_API_TOKEN "$GITHUB_API_TOKEN"
ENV SURGE_TOKEN "$SURGE_TOKEN"
ENV SURGE_LOGIN "$SURGE_LOGIN"

RUN chmod +x .docker/scripts/install_hugo.sh
RUN chmod +x .docker/scripts/build.sh
RUN chmod +x .docker/scripts/deploy.sh

RUN .docker/scripts/install_hugo.sh
RUN .docker/scripts/build.sh
ENTRYPOINT .docker/scripts/deploy.sh; /bin/bash
