#!bin/bash

cd ./easy-rsa-3.0.1/easyrsa3
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa gen-dh
openvpn --genkey --secret ta.key
./easyrsa gen-req $1 nopass
./easyrsa sign-req $2 $1
cp ./pki/dh.pem ../../crt/ca
cp ./pki/ca.crt ../../crt/ca
cp ./ta.key ../../crt/ca
cp ./pki/issued/sky-vpn.crt ../../crt/server
cp ./pki/private/sky-vpn.key ../../crt/server
