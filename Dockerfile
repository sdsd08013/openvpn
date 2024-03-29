FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV EASYRSA_BATCH=1

RUN apt-get update && apt-get install -y apt-transport-https \
	openvpn \
	openssl \
	vim \
	wget \
	iptables \
	net-tools

RUN	echo 'deb http://private-repo-1.hortonworks.com/HDP/ubuntu14/2.x/updates/2.4.2.0 HDP main' >> /etc/apt/sources.list.d/HDP.list && \
	echo 'deb http://private-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/ubuntu14 HDP-UTILS main'  >> /etc/apt/sources.list.d/HDP.list && \
	echo 'deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/azurecore/ trusty main' >> /etc/apt/sources.list.d/azure-public-trusty.list && \
	sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf && sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf

WORKDIR /etc/openvpn
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#add-or-copy
COPY server.conf client.conf ./
COPY ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

CMD ["start.sh"]
