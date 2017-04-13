#
# Dockerfile for kcptun-client
#

FROM alpine
MAINTAINER Vincent.Gu <g@v-io.co>

ENV KCPTUN_LISTEN_ADDR   127.0.0.1
ENV KCPTUN_LISTEN_PORT   29900
ENV KCPTUN_REMOTE_ADDR   127.0.0.1
ENV KCPTUN_REMOTE_PORT   8388
ENV KCPTUN_KEY           password
ENV KCPTUN_CRYPT         aes
ENV KCPTUN_MODE          fast2
ENV KCPTUN_CONN          1
ENV KCPTUN_AUTO_EXPIRE   0
ENV KCPTUN_MTU           1200
ENV KCPTUN_SNDWND        1024
ENV KCPTUN_RCVWND        1024
ENV KCPTUN_DATASHARD     10
ENV KCPTUN_PARITYSHARD   3
ENV KCPTUN_DSCP          46
ENV KCPTUN_NOCOMP        true
ENV KCPTUN_LOG           /dev/null

# define default directory
ENV APP_DIR              /srv/kcptun
WORKDIR $APP_DIR

EXPOSE $KCPTUN_LISTEN_PORT/tcp

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# build kcptun
ENV KCPTUN_VER 20170329
ENV KCPTUN_URL https://github.com/xtaci/kcptun/releases/download/v${KCPTUN_VER}/kcptun-linux-amd64-${KCPTUN_VER}.tar.gz
RUN set -ex \
    && curl -sSL $KCPTUN_URL | tar xz \
    && rm -rf /var/cache/apk/*
