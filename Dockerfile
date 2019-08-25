FROM alpine
ADD . ./app
WORKDIR /app

RUN apk add --no-cache curl
RUN apk add --no-cache wget
RUN apk add --no-cache bash

RUN chmod +x .docker/scripts/install_hugo.sh
RUN chmod +x .docker/scripts/build.sh
RUN chmod +x .docker/scripts/deploy.sh

RUN .docker/scripts/install_hugo.sh
RUN .docker/scripts/build.sh
ENTRYPOINT .docker/scripts/deploy.sh; /bin/bash
