#!bin/bash

cd ./easy-rsa-3.0.1/easyrsa3
./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-dh
openvpn --genkey --secret ta.key
./easyrsa gen-req $1
./easyrsa sign-req $1 $2
