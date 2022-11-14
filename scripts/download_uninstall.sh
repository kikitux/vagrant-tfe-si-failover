#!/usr/bin/env bash

curl https://install.terraform.io/tfe/uninstall > /root/uninstall.sh
chmod +x /root/uninstall.sh

cat >> /root/uninstall.sh <<EOF
[ -d /mnt/tfe ] && rm -fr /mnt/tfe
mkdir -p /mnt/tfe
EOF
