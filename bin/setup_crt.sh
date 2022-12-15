#!bin/bash

cd ./easy-rsa-3.0.1/easyrsa3
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa gen-dh
openvpn --genkey --secret ta.key
# server cert
echo "--------gen server crt----------"
./easyrsa build-server-full server nopass
# client cert
# echo "--------gen client crt----------"
./easyrsa build-client-full client nopass
cp ./pki/dh.pem ./pki/ca.crt ./ta.key ../../crt/ca
cp ./pki/issued/server.crt ./pki/private/server.key ../../crt/server
cp ./pki/issued/client.crt ./pki/private/client.key ../../crt/client
