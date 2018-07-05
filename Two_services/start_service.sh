#!/bin/sh
python3 /code/service.py > /dev/null 2>&1 &
envoy -c output_test.yaml --v2-config-only > /dev/null 2>&1 &
