#!/usr/bin/env bash
set -e

# ====== Internal Variables ======
KCPTUN_CONF="client-config.json"
# ====== Internal Variables ======


# ====== Generate KCPTUN config ======
cat > ${KCPTUN_CONF} <<-EOF
{
    "localaddr": "${KCPTUN_CLIENT_LISTEN_ADDR}:${KCPTUN_CLIENT_LISTEN_PORT}",
    "remoteaddr": "${KCPTUN_CLIENT_TARGET_ADDR}:${KCPTUN_CLIENT_TARGET_PORT}",
    "key": "${KCPTUN_KEY}",
    "crypt": "${KCPTUN_CRYPT}",
    "mode": "${KCPTUN_MODE}",
    "conn": ${KCPTUN_CONN},
    "autoexpire": ${KCPTUN_AUTO_EXPIRE},
    "mtu": ${KCPTUN_MTU},
    "sndwnd": ${KCPTUN_SNDWND},
    "rcvwnd": ${KCPTUN_RCVWND},
    "datashard": ${KCPTUN_DATASHARD},
    "parityshard": ${KCPTUN_PARITYSHARD},
    "dscp": ${KCPTUN_DSCP},
    "nocomp": ${KCPTUN_NOCOMP},
    "log": "${KCPTUN_LOG}"
}
EOF
# ====== Generate KCPTUN config ======


echo "Starting kcptun ..."
./client_linux_amd64 -v
echo "+---------------------------------------------------------+"
echo "KCP Listen     : ${KCPTUN_CLIENT_LISTEN_ADDR}:${KCPTUN_CLIENT_LISTEN_PORT}"
echo "KCP Parameter: --crypt ${KCPTUN_CRYPT} --key ${KCPTUN_KEY} --mtu ${KCPTUN_MTU} --sndwnd ${KCPTUN_SNDWND} --rcvwnd ${KCPTUN_RCVWND} --mode ${KCPTUN_MODE} --nocomp ${KCPTUN_NOCOMP}" --dscp ${KCPTUN_DSCP}
echo "+---------------------------------------------------------+"
exec "./client_linux_amd64" -c ${KCPTUN_CONF}
