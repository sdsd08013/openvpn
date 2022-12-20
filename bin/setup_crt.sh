#!bin/bash

rm -rf ./crt/ca/*
rm -rf ./crt/client/*
rm -rf ./crt/server/*

cd ./crt
wget https://github.com/OpenVPN/easy-rsa/archive/3.0.1.tar.gz && tar xzvf 3.0.1.tar.gz && rm 3.0.1.tar.gz

cd ./easy-rsa-3.0.1/easyrsa3
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa gen-dh
openvpn --genkey --secret ta.key
# server cert
echo "--------gen server crt----------"
./easyrsa build-server-full server nopass
cp ./pki/dh.pem ./pki/ca.crt ./ta.key ../../ca
cp ./pki/issued/server.crt ./pki/private/server.key ../../server
