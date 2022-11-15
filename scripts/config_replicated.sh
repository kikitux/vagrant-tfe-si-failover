#!/usr/bin/env bash

LOCALIP=`hostname -I | xargs -n1 | grep 192.168`
LOCALURL=${LOCALIP}.nip.io

cat > /etc/replicated.conf <<EOF
{
  "BypassPreflightChecks": true,
  "DaemonAuthenticationType": "password",
  "DaemonAuthenticationPassword": "Password1#",
  "ImportSettingsFrom": "/etc/settings.json",
  "LicenseFileLocation": "/vagrant/license.rli",
  "ReleaseSequence": 0,
  "TlsBootstrapType": "self-signed",
  "TlsBootstrapHostname": "${LOCALURL}"
}
EOF

cat > /etc/settings.json <<EOF
{
    "hostname": {
        "value": "${LOCALURL}"
    },
    "disk_path": {
        "value": "/mnt/tfe"
    },
    "enc_password": {
        "value": "Password1#"
    },
    "generated_postgres_password": {
        "value": "Password1#"        
    }
}
EOF

chmod 0644 /etc/settings.json /etc/replicated.conf
