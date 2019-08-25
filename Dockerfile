FROM alpine
ADD . ./app
WORKDIR /app
CMD [pwd]
RUN apt-get update && apt-get install -y curl
CMD [".docker/scripts/install_hugo.sh", ".docker/scripts/build.sh"]
