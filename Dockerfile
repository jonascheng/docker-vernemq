FROM ubuntu:14.04

RUN     export DEBIAN_FRONTEND=noninteractive && apt-get install -yq curl 

RUN     export DEBIAN_FRONTEND=noninteractive && curl -k https://packagecloud.io/gpg.key | apt-key add -

RUN     export DEBIAN_FRONTEND=noninteractive && echo -n | openssl s_client -connect packagecloud.io:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | tee '/usr/local/share/ca-certificates/packagecloud_io.crt'

RUN     export DEBIAN_FRONTEND=noninteractive && update-ca-certificates

RUN     export DEBIAN_FRONTEND=noninteractive && echo "deb https://packagecloud.io/erlio/vernemq/ubuntu/ trusty main" > /etc/apt/sources.list.d/erlio_vernemq.list

RUN     export DEBIAN_FRONTEND=noninteractive && echo "deb-src https://packagecloud.io/erlio/vernemq/ubuntu/ trusty main" >> /etc/apt/sources.list.d/erlio_vernemq.list

RUN     export DEBIAN_FRONTEND=noninteractive && apt-get install -yq apt-transport-https

RUN     export DEBIAN_FRONTEND=noninteractive && apt-get -y update 

RUN     export DEBIAN_FRONTEND=noninteractive && apt-get install -yq mosquitto-clients

RUN     export DEBIAN_FRONTEND=noninteractive && apt-get install -yq vernemq 

RUN     export DEBIAN_FRONTEND=noninteractive && apt-get -yq clean

COPY    run.sh /
#COPY	vernemq.conf.default vmq.passwd.default vmq.acl.default /tmp/

RUN	chmod +x /run.sh

VOLUME	/etc/vernemq
VOLUME	/var/lib/vernemq
VOLUME  /var/log/vernemq

EXPOSE  1883
EXPOSE  4369
EXPOSE  18000-18999

ENTRYPOINT	["./run.sh"]
