#!/bin/bash

#start envoy and the service
nohup /usr/local/bin/start_service.sh &
# start snort
#/usr/local/bin/snort -A console -q -c /etc/snort/snort.conf -i eth0 -N
/usr/local/bin/snort -D -q -c /etc/snort/snort.conf -i eth0 -N


#ipset create blacklist hash:ip hashsize 4096
#iptables -I INPUT -m set --match-set blacklist src -j DROP
#iptables -I FORWARD -m set --match-set blacklist src -j DROP
