#!/usr/bin/env bash

LOCALIP=`hostname -I | xargs -n1 | grep 192.168`
LOCALURL=${LOCALIP}.nip.io

if [ ! -f /etc/iact.txt ]; then
  initial_token=$(replicated admin --tty=0 retrieve-iact | tr -d '\r')
  echo ${initial_token} > /etc/iact.txt
fi

if [ ! -f /etc/tfe_initial_user.json ]; then

  cat > /var/tmp/initial_user.json <<EOF
{
  "username": "admin",
  "email": "alvaro@hashicorp.com",
  "password": "Password1#"
}
EOF

  curl -k \
    --header "Content-Type: application/json" \
    --request POST \
    --data @/var/tmp/initial_user.json \
    https://${LOCALURL}/admin/initial-admin-user?token=${initial_token} | tee /etc/tfe_initial_user.json
    
fi
              
