FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-transport-https
RUN echo 'deb http://private-repo-1.hortonworks.com/HDP/ubuntu14/2.x/updates/2.4.2.0 HDP main' >> /etc/apt/sources.list.d/HDP.list
RUN echo 'deb http://private-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/ubuntu14 HDP-UTILS main'  >> /etc/apt/sources.list.d/HDP.list
RUN echo 'deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/azurecore/ trusty main' >> /etc/apt/sources.list.d/azure-public-trusty.list

RUN apt-get install -y openvpn vim net-tools
#RUN mkdir /dev/net
#RUN mknod /dev/net/tun c 10 200

#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
#USER docker
EXPOSE 8000

WORKDIR /etc/openvpn
COPY ./server.conf /etc/openvpn
COPY ./ca.crt /etc/openvpn
COPY ./dh.pem /etc/openvpn
COPY ./server.key /etc/openvpn
COPY ./server.crt /etc/openvpn
COPY ./ta.key /etc/openvpn

CMD ["openvpn", "server.conf"]
