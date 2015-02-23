#!/bin/bash

# exit on any non-zero status
set -e

# setup minimal config if no config is found
if [ ! -f /etc/freeswitch/freeswitch.xml ]; then
  git clone https://github.com/spali/freeswitch_conf_minimal.git /etc/freeswitch
  # fix permissions and ownership
  chown -R freeswitch:freeswitch /etc/freeswitch
  chmod -R 700 /etc/freeswitch
fi
