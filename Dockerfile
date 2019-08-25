FROM alpine
ADD . ./app
WORKDIR /app
CMD [pwd]
RUN apk add --no-cache curl
CMD [".docker/scripts/install_hugo.sh", ".docker/scripts/build.sh"]
