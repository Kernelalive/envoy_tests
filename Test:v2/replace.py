#!/usr/bin/python

import ruamel.yaml
import os

file_name = '/etc/service-envoy.yaml'
from ruamel.yaml.util import load_yaml_guess_indent

config, ind, bsi = load_yaml_guess_indent(open(file_name))

static_resources = config['static_resources']
static_resources['clusters'][0]['hosts'][0]['socket_address']['port_value'] = os.environ['PORT_V']
#instances[0]['username'] = 'Username'
#instances[0]['password'] = 'Password'

ruamel.yaml.round_trip_dump(config, open('output.yaml', 'w'), 
                            indent=ind, block_seq_indent=bsi)






