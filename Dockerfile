FROM alpine
ADD . ./app
WORKDIR /app

RUN apk add --no-cache curl
RUN apk add --no-cache wget

RUN chmod +x .docker/scripts/install_hugo.sh
RUN chmod +x .docker/scripts/build.sh
RUN chmod +x .docker/scripts/deploy.sh

CMD [".docker/scripts/install_hugo.sh"]
CMD [".docker/scripts/build.sh"]
CMD [".docker/scripts/deploy.sh"]
