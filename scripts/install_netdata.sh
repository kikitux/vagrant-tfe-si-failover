#!/usr/bin/env bash

curl https://my-netdata.io/kickstart.sh -o /tmp/netdata-kickstart.sh
sh /tmp/netdata-kickstart.sh --stable-channel --disable-telemetry
