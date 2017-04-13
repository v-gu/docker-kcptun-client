#!/usr/bin/env bash

set -e

KCPTUN_CONF="config.json"
# ======= KCPTUN CONFIG ======
KCPTUN_LISTEN_ADDR=${KCPTUN_LISTEN_ADDR:-127.0.0.1}           #"listen addr": "127.0.0.1"
KCPTUN_LISTEN_PORT=${KCPTUN_LISTEN_PORT:-29900}               #"listen addr": "29900"
KCPTUN_REMOTE_ADDR=${KCPTUN_REMOTE_ADDR:-127.0.0.1}           #"remote addr": "127.0.0.1"
KCPTUN_REMOTE_PORT=${KCPTUN_REMOTE_PORT:-8388}                #"remote port": "8388"
KCPTUN_KEY=${KCPTUN_KEY:-password}                            #"key": "password",
KCPTUN_CRYPT=${KCPTUN_CRYPT:-aes}                             #"crypt": "aes",
KCPTUN_MODE=${KCPTUN_MODE:-fast2}                             #"mode": "fast2",
KCPTUN_CONN=${KCPTUN_CONN:-1}                                 #"conn": 1,
KCPTUN_AUTO_EXPIRE=${KCPTUN_AUTO_EXPIRE:0}                    #"autoexpire": 0,
KCPTUN_MTU=${KCPTUN_MTU:-1350}                                #"mtu": 1350,
KCPTUN_SNDWND=${KCPTUN_SNDWND:-1024}                          #"sndwnd": 1024,
KCPTUN_RCVWND=${KCPTUN_RCVWND:-1024}                          #"rcvwnd": 1024,
KCPTUN_DATASHARD=${KCPTUN_DATASHARD:-10}                      #"datashard": 10,
KCPTUN_PARITYSHARD=${KCPTUN_PARITYSHARD:-10}                  #"parityshard": 3,
KCPTUN_DSCP=${KCPTUN_DSCP:-46}                                #"dscp": 46
KCPTUN_NOCOMP=${KCPTUN_NOCOMP:-true}                          #"nocomp": true
KCPTUN_LOG=${KCPTUN_LOG:-/dev/null}                           #"log": /dev/null

cat > ${KCPTUN_CONF}<<-EOF
{
    "localaddr": "${KCPTUN_LISTEN_ADDR}:${KCPTUN_LISTEN_PORT}",
    "remoteaddr": "${KCPTUN_REMOTE_ADDR}:${KCPTUN_REMOTE_PORT}",
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

echo "Starting Kcptun for Shadowsocks-libev..."
./client_linux_amd64 -v
echo "+---------------------------------------------------------+"
echo "KCP Listen     : ${KCPTUN_LISTEN_ADDR}:${KCPTUN_LISTEN_PORT}"
echo "KCP Parameter: --crypt ${KCPTUN_CRYPT} --key ${KCPTUN_KEY} --mtu ${KCPTUN_MTU} --sndwnd ${KCPTUN_SNDWND} --rcvwnd ${KCPTUN_RCVWND} --mode ${KCPTUN_MODE} --nocomp ${KCPTUN_NOCOMP}" --dscp ${KCPTUN_DSCP}
echo "+---------------------------------------------------------+"
exec "./client_linux_amd64" -c ${KCPTUN_CONF}
