#
# Dockerfile for kcptun-client
#

FROM lisnaz/kcptun:latest
MAINTAINER Vincent.Gu <g@v-io.co>

ENV KCPTUN_CLIENT_LISTEN_ADDR   127.0.0.1
ENV KCPTUN_CLIENT_LISTEN_PORT   4000
ENV KCPTUN_CLIENT_TARGET_ADDR   127.0.0.1
ENV KCPTUN_CLIENT_TARGET_PORT   4000
ENV SS_TARGET_UDP_PORT          8388

EXPOSE $KCPTUN_CLIENT_LISTEN_PORT/tcp

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# install dependencies
ENV KCPTUN_DEP bash iptables
RUN set -ex \
    && apk add --update --no-cache $KCPTUN_DEP \
    && rm -rf /var/cache/apk/* \
