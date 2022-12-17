# openvpn
openvpn docker

## setup
```
sudo docker run --privileged  -v /home/sky/openvpn/client_crt:/etc/openvpn/client_crt -p 1194:1194/udp -ti openvpn
bash setup_crt.sh
bash make_config.sh client client-conf-name
```


## start openvpn server
```
sudo docker run --privileged  -v /home/sky/openvpn/client_crt:/etc/openvpn/client_crt -p 1194:1194/udp -ti openvpn
bash start.sh
```
