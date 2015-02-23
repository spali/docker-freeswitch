#!/bin/bash
set -e

if [ "$1" = '/usr/bin/freeswitch -c' ]; then
	chown -R freeswitch "$FREESWITCH_CONF"

	# setup minimal config if no config is found
	if [ ! -f "$FREESWITCH_CONF"/freeswitch.xml ]; then
		git clone https://github.com/spali/freeswitch_conf_minimal.git "$FREESWITCH_CONF"
	fi

fi      

exec $@


