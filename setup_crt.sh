#!bin/bash

cd ./easy-rsa-3.0.1/easyrsa3
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa gen-dh
openvpn --genkey --secret ta.key
./easyrsa gen-req $1
./easyrsa sign-req $2 $1
cp ./pki/dh.pem ../../client
cp ./pki/ca.crt ../../client
cp ./ta.key ../../client
cp ./pki/issued/sky-vpn.crt ../../server
cp ./pki/private/sky-vpn.key ../../server
