#!/bin/bash

KEY_DIR=./ca
SERVER_DIR=./server
OUTPUT_DIR=./client
BASE_CONFIG=./client.conf

cat ${BASE_CONFIG} <(echo -e '<ca>') ${KEY_DIR}/ca.crt <(echo -e '</ca>\n<cert>') ${SERVER_DIR}/${1}.crt <(echo -e '</cert>\n<key>') ${SERVER_DIR}/${1}.key <(echo -e '</key>\n<tls-crypt>') ${KEY_DIR}/ta.key <(echo -e '</tls-crypt>') > ${OUTPUT_DIR}/${2}.ovpn
