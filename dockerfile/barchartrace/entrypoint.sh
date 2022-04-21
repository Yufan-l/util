#!/bin/bash


if [[ ! -z "${REPLACE_ENV}" ]]; then
   sed -i 's,http://localhost:8080,'"$REPLACE_ENV"',g' /usr/share/nginx/html/index.html
fi


nginx -g 'daemon off;'
