#!/bin/sh
python3 /code/service.py &
envoy -c /etc/service-envoy.yaml --v2-config-only
