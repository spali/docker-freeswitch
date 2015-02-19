#!/bin/bash

# exit on any non-zero status
set -e

# copy vanilla config if no config is found
if [ ! -f /etc/freeswitch/freeswitch.xml ]; then
  cp -a /usr/share/freeswitch/conf/vanilla /etc/freeswitch
  # fix permissions and ownership
  chown -R freeswitch:freeswitch /etc/freeswitch
  chmod 700 /etc/freeswitch
fi
