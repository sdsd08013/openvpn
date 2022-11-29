FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV EASYRSA_BATCH=1

RUN apt-get update && apt-get install -y apt-transport-https \
	openvpn \
	openssl \
	vim \
	wget \
	iptables \
	net-tools
RUN wget https://github.com/OpenVPN/easy-rsa/archive/3.0.1.tar.gz && tar xzvf 3.0.1.tar.gz && rm 3.0.1.tar.gz
RUN echo 'deb http://private-repo-1.hortonworks.com/HDP/ubuntu14/2.x/updates/2.4.2.0 HDP main' >> /etc/apt/sources.list.d/HDP.list
RUN echo 'deb http://private-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/ubuntu14 HDP-UTILS main'  >> /etc/apt/sources.list.d/HDP.list
RUN echo 'deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/azurecore/ trusty main' >> /etc/apt/sources.list.d/azure-public-trusty.list

RUN sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf && sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf

WORKDIR /etc/openvpn
RUN wget https://github.com/OpenVPN/easy-rsa/archive/3.0.1.tar.gz && tar xzvf 3.0.1.tar.gz && rm 3.0.1.tar.gz

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#add-or-copy
COPY server.conf client.conf make_config.sh setup_crt.sh ./
ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

CMD ["start.sh"]
