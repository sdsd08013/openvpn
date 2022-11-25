FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV EASYRSA_BATCH=1

RUN apt-get update && apt-get install -y apt-transport-https \
	openvpn \
	openssl \
	vim \
	wget \
	net-tools

RUN echo 'deb http://private-repo-1.hortonworks.com/HDP/ubuntu14/2.x/updates/2.4.2.0 HDP main' >> /etc/apt/sources.list.d/HDP.list
RUN echo 'deb http://private-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/ubuntu14 HDP-UTILS main'  >> /etc/apt/sources.list.d/HDP.list
RUN echo 'deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/azurecore/ trusty main' >> /etc/apt/sources.list.d/azure-public-trusty.list

#RUN iptables -t nat -A POSTROUTING -o eth0 -s 10.8.0.0/24 -j MASQUERADE
RUN sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf && sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf

WORKDIR /etc/openvpn
RUN wget https://github.com/OpenVPN/easy-rsa/archive/3.0.1.tar.gz && tar xzvf 3.0.1.tar.gz && rm 3.0.1.tar.gz

#COPY server.conf ca.crt dh.pem server.key server.crt ta.key setup_crt.sh ./
COPY make_config.sh setup_crt.sh ./
RUN chmod -R 755 ./setup_crt.sh

CMD ["openvpn", "server.conf"]
