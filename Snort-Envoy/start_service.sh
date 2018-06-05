#!/bin/sh
python3 /code/service.py &
envoy -c /code/output.yaml --v2-config-only
