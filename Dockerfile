#
# Dockerfile for kcptun-client
#

FROM lisnaz/kcptun:latest
MAINTAINER Vincent.Gu <g@v-io.co>

EXPOSE $KCPTUN_CLIENT_LISTEN_PORT/tcp

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
