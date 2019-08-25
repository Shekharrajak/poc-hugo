#!/bin/bash

hugo

minify --recursive --verbose \
        --match=\.*.js$ \
        --type=js \
        --output ../../public/ \
        ../../public/

minify --recursive --verbose \
        --match=\.*.css$ \
        --type=css \
        --output ../../public/ \
        ../../public/

minify --recursive --verbose \
        --match=\.*.html$ \
        --type=html \
        --output ../../public/ \
        ../../public/
