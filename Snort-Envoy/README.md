# Snort - Envoy 

Snort IDS side by side with Envoy and a webservice 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


### Installing and Testing

A step by step series of examples that tell you how to get  running example

Build the container
```
docker build -t snort-envoy:v3 .
```

Log into the container

```
docker run --privileged --cap-add=NET_RAW -ti --name exhibition snort-envoy:v3 bash
```
Set an ip blacklist

```
sh /usr/local/bin/blacklist.sh
```

Put the unwanted Ip inside the blacklist 

```
ipset add blacklist 172.17.0.1 (remove an ip with (ipset del blacklist 172.17.0.1))
```
Start snort and envoy

```
./start_snort_script.sh
```

## Running the tests
Ping/curl the container and snort will alert you about the ping iptables will block the ICMP request.