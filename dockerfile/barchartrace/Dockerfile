from nginx:1.20

#COPY nginx.conf /etc/nginx/nginx.conf
ADD . /usr/share/nginx/html/
ADD entrypoint.sh /


CMD ["/entrypoint.sh"]