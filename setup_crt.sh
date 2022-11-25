#!bin/bash

cd ./easy-rsa-3.0.1/easyrsa3
./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-dh
openvpn --genkey --secret ta.key
./easyrsa gen-req $1 nopass
./easyrsa sign-req $2 $1
cp ./pki/dh.pem ../../ca
cp ./pki/ca.crt ../../ca
cp ./ta.key ../../ca
cp ./pki/issued/sky-vpn.crt ../../server
cp ./pki/private/sky-vpn.key ../../server
