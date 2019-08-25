FROM alpine
ADD . ./app
WORKDIR /app
CMD [pwd]
CMD [".docker/scripts/install_hugo.sh", ".docker/scripts/build.sh"]
