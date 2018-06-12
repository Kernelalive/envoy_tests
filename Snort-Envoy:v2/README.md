# Snort - Envoy 

Snort IDS side by side with Envoy and a webservice 

## Getting Started

### Installing and Testing

A step by step series of examples that tell you how to get  running example of Snort-Envoy in IDS mode

Create the network

```
docker network create myNetwork
```

Build the container
```
docker build -t snort-envoy-ips:v1 .
```

Log into the container

```
docker run --privileged --cap-add=NET_RAW -ti --name ips snort-envoy-ips:v1 bash
```

Connect to the second network 
```
docker network connect myNetwork ips
```
```
docker attach ips
```

Forward Traffic from one interface to another

```
(echo 1 > /proc/sys/net/ipv4/ip_forward) or
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sysctl -p
sysctl --system
check if forward mode is enabled sysctl net.ipv4.ip_forward
```

Bridge the two itherfaces
```
iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

```
As netfilter is a stateless firewall, allow traffic for already established connections

```
iptables -A FORWARD -i eth1 -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
```
Change the source address on packets going out to the internet
```
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
```
Start services
```
nohup /usr/local/bin/start_service.sh &
```

Change envoy to listen to eth1 ip address 

Start snort
```
snort -A console -c /etc/snort/snort.conf -Q -i eth0:eth1 -N
```


## Running the tests
Ping/curl the container and snort will alert you about the ping Snort will block the ICMP/TCP request.

