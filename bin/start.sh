iptables -t nat -A POSTROUTING -o eth0 -s 10.8.0.0/24 -j MASQUERADE

openvpn server.conf
