#!/usr/bin/env bash
set -e

# ====== Internal Variables ======
KCPTUN_CONF="client-config.json"
# ====== Internal Variables ======


# ====== generate and install iptable rules ======
echo "preparing iptables ..."
iptables -tnat -I OUTPUT -d ${KCPTUN_CLIENT_LISTEN_ADDR} -p udp --dport ${KCPTUN_CLIENT_LISTEN_PORT} -j DNAT --to-destination ${KCPTUN_CLIENT_TARGET_ADDR}:${SS_TARGET_UDP_PORT}
iptables -tnat -A POSTROUTING -j MASQUERADE
echo "done iptables"
# ====== generate and install iptable rules ======

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


echo "Starting kcptun client ..."
./client_linux_amd64 -v
echo "+---------------------------------------------------------+"
echo "KCP Listen     : ${KCPTUN_CLIENT_LISTEN_ADDR}:${KCPTUN_CLIENT_LISTEN_PORT}"
echo "KCP Parameter: --crypt ${KCPTUN_CRYPT} --key ${KCPTUN_KEY} --mtu ${KCPTUN_MTU} --sndwnd ${KCPTUN_SNDWND} --rcvwnd ${KCPTUN_RCVWND} --mode ${KCPTUN_MODE} --nocomp ${KCPTUN_NOCOMP} --dscp ${KCPTUN_DSCP}"
echo "+---------------------------------------------------------+"
exec "./client_linux_amd64" -c ${KCPTUN_CONF}
