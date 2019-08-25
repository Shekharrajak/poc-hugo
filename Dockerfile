FROM alpine
ADD . ./app
WORKDIR /app
CMD [pwd]
CMD ["app/.docker/scripts/install_hugo.sh", "app/.docker/scripts/build.sh"]
