#!/bin/bash
set -e

KEY_DIR=./crt/ca
CLIENT_DIR=./crt/client
OUTPUT_DIR=./crt/ovpn
BASE_CONFIG=./client.conf

REQ_FILE=./crt/easy-rsa-3.0.1/easyrsa3/pki/reqs/${1}.req
KEY_FILE=./crt/easy-rsa-3.0.1/easyrsa3/pki/private/${1}.key

if [ -f "$REQ_FILE" ]; then
    echo "$REQ_FILE exists."
    exit 0
fi

if [ -f "$KEY_FILE" ]; then
    echo "$KEY_FILE exists."
    exit 0
fi

cd ./crt/easy-rsa-3.0.1/easyrsa3

# client cert
echo "--------gen client crt----------"
./easyrsa build-client-full $1 nopass
cp ./pki/issued/${1}.crt ./pki/private/${1}.key ../../client

echo "--------make client conf----------"
cd ../../../
cat ${BASE_CONFIG} <(echo -e '<ca>') ${KEY_DIR}/ca.crt <(echo -e '</ca>\n<cert>') ${CLIENT_DIR}/${1}.crt <(echo -e '</cert>\n<key>') ${CLIENT_DIR}/${1}.key <(echo -e '</key>\nkey-direction 1\n<tls-auth>') ${KEY_DIR}/ta.key <(echo -e '</tls-auth>') > ${OUTPUT_DIR}/${1}.ovpn
