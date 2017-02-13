#
# Dockerfile for kcptun-client
#

FROM alpine
MAINTAINER Vincent.Gu <0x6c34@gmail.com>

ENV KCPTUN_SERVER_ADDR   127.0.0.1
ENV KCPTUN_SERVER_PORT   8388
ENV KCPTUN_CLIENT_ADDR   ""
ENV KCPTUN_CLIENT_PORT   8388
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

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# build software stack
ENV DEP iptables ipset iproute2 netcat-openbsd drill curl tcpdump bash pcre mtr
RUN set -ex \
    && apk add --update $DEP \
    && rm -rf /var/cache/apk/*

# build kcptun
ENV BASE_DIR /opt
ENV KCPTUN_VER 20170120
ENV KCPTUN_URL https://github.com/xtaci/kcptun/releases/download/v${KCPTUN_VER}/kcptun-linux-amd64-${KCPTUN_VER}.tar.gz
ENV KCPTUN_DIR kcptun
RUN set -ex \
    && mkdir -p $BASE_DIR/$KCPTUN_DIR \
    && cd $BASE_DIR/$KCPTUN_DIR \
    && curl -sSL $KCPTUN_URL | tar xz \
    && rm -rf /var/cache/apk/*
