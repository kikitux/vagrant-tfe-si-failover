#!/usr/bin/env bash

LOCALIP=`hostname -I | xargs -n1 | grep 192.168`
LOCALURL=${LOCALIP}.nip.io
LOCALPORT=443

echo ${LOCALURL}:${LOCALPORT}

#echo "HEAD / HTTP/1.0\n Host: ${LOCALURL}:${LOCALPORT}\n\n EOT\n" | openssl s_client -prexit -connect ${LOCALURL}:${LOCALPORT} > /etc/ssl/certs/tfe.pem

openssl s_client -showcerts -connect ${LOCALURL}:${LOCALPORT} -servername ${LOCALURL} < /dev/null 2>/dev/null | openssl x509 -outform PEM >  /etc/ssl/certs/tfe.pem

update-ca-certificates --fresh
