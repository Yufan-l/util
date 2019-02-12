From klauspost/geoip-service

RUN wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz && \
    tar -xvf GeoLite2-City.tar.gz && \
    mv GeoLite2-City_*/GeoLite2-City.mmdb /data/

CMD ["app", "-db=/data/GeoLite2-City.mmdb"]
 





