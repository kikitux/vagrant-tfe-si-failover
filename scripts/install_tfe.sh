#!/bin/bash

mkdir -p /mnt/tfe

LOCALIP=`hostname -I | xargs -n1 | grep 192.168`
LOCALURL=${LOCALIP}.nip.io

curl -o install.sh https://install.terraform.io/ptfe/stable
bash ./install.sh \
  no-proxy \
  private-address=${LOCALIP} \
  public-address=${LOCALIP}

# Once the installer finishes, you may poll the /_health_check endpoint until a 200 is returned by the application, 
# indicating that it is fully started

while ! curl -kLsfS --connect-timeout 5 http://${LOCALURL} &>/dev/null ; do
  echo "INFO: TFE has not been yet fully started"
  echo "INFO: sleeping 90 seconds"
  sleep 90
done

echo "INFO: TFE is up and running"
