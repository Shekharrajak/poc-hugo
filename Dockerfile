FROM mysocialobservations/docker-tdewolff-minify
ADD . ./app
WORKDIR /app
RUN chmod +x ./docker/scripts/install_hugo.sh
CMD ["./docker/scripts/install_hugo.sh"]

RUN hugo
RUN minify --recursive --verbose \
        --match=\.*.js$ \
        --type=js \
        --output public/ \
        public/

RUN minify --recursive --verbose \
        --match=\.*.css$ \
        --type=css \
        --output public/ \
        public/

RUN minify --recursive --verbose \
        --match=\.*.html$ \
        --type=html \
        --output public/ \
        public/
