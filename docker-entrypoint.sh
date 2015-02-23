#!/bin/bash
set -e

if [ "$1" = '/docker-command.sh' ]; then

	# setup minimal config if no config is found
	if [ ! -f "$FREESWITCH_CONF"/freeswitch.xml ]; then
		git clone https://github.com/spali/freeswitch_conf_minimal.git "$FREESWITCH_CONF"
	fi

	chown -R freeswitch:freeswitch "$FREESWITCH_CONF"

fi      

exec $@


