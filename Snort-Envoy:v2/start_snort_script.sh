#!/bin/bash

#start envoy and the service
nohup /usr/local/bin/start_service.sh &

# start snort
/usr/local/bin/snort -A console -q -c /etc/snort/snort.conf -i eth0 -N
#/usr/local/bin/snort -D -q -c /etc/snort/snort.conf -i eth0 -N

