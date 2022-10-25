ARG TZ=Asia/Tokyo
FROM alpine:latest

RUN    apk update \
    && apk add --no-cache bash tzdata tini \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ sslh \
    && rm -rf /var/cache/apk/*

ADD ./entry.sh /entry.sh
RUN chmod +x /entry.sh

ENTRYPOINT ["/sbin/tini", "-e", "143", "--"]
CMD ["/entry.sh"]
