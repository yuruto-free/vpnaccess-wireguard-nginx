FROM nginx:alpine
ARG TZ=Asia/Tokyo

LABEL maintainer="yuruto"
LABEL description="build nginx"

# Install
RUN    apk --no-cache update \
    && apk --no-cache add bash tzdata gettext \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apk add --no-cache php php-mbstring php-openssl certbot \
    && mkdir -p /etc/letsencrypt \
    && mkdir -p /etc/nginx/template \
    && mkdir -p /data \
    && rm -rf /var/cache/apk/*

# Set environment
ENV MYDNSJP_MASTER_ID=masterid \
    MYDNSJP_PASSWORD=password \
    MYDNS_EMAIL_ADDR=user@example.com \
    BASE_DOMAIN_NAME=example.com \
    VHOST_NAME=www.example.com \
    SSL_CERT_PATH=/etc/nginx/default_certs/default.crt \
    SSL_CERTKEY_PATH=/etc/nginx/default_certs/default.key \
    SSL_STAPLING_VERIFY=off \
    SSL_TRUSTED_CERTIFICATE_PATH=/etc/nginx/default_certs/default.crt \
    PUBLIC_SERVER_IP_ADDR=10.0.16.3 \
    PUBLIC_SERVER_PORT=8080

VOLUME ["/etc/letsencrypt"]

# add dns-01 script
COPY ./direct_edit /data/direct_edit
# copy certs to default_certs
COPY ./local_certs /etc/nginx/default_certs

COPY ./execute.sh /execute.sh
RUN    chmod 755 /execute.sh \
    && chmod 600 /data/direct_edit/*.conf \
    && chmod 700 /data/direct_edit/*.php \
    && cp -f /var/spool/cron/crontabs/root /data/original.root

EXPOSE 443

CMD ["/execute.sh"]
