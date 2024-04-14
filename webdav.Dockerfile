FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    nginx \
                    nginx-extras \
                    apache2-utils && \
                    rm -rf /var/lib/apt/lists

VOLUME /media
EXPOSE 80

WORKDIR /

COPY ./webdav.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/*

COPY ./webdav_entrypoint.sh entrypoint.sh 
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]