#!/bin/bash

KEY_DIR=./crt/ca
CLIENT_DIR=./crt/client
OUTPUT_DIR=./crt/client
BASE_CONFIG=./client.conf

cat ${BASE_CONFIG} <(echo -e '<ca>') ${KEY_DIR}/ca.crt <(echo -e '</ca>\n<cert>') ${CLIENT_DIR}/${1}.crt <(echo -e '</cert>\n<key>') ${CLIENT_DIR}/${1}.key <(echo -e '</key>\nkey-direction 1\n<tls-auth>') ${KEY_DIR}/ta.key <(echo -e '</tls-auth>') > ${OUTPUT_DIR}/${2}.ovpn
