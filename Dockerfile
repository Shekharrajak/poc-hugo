FROM alpine
ADD . ./app
WORKDIR /app

RUN apk add --no-cache curl
RUN apk add --no-cache wget

RUN chmod +x .docker/scripts/install_hugo.sh
RUN chmod +x .docker/scripts/build.sh

CMD [".docker/scripts/install_hugo.sh", ".docker/scripts/build.sh"]
