#!/bin/bash

set -e

if [ "$1" = 'freeswitch' ]; then
	chown -R freeswitch "$FSCONF"

	# setup minimal config if no config is found
	if [ ! -f "$FSCONF"/freeswitch.xml ]; then
		git clone https://github.com/spali/freeswitch_conf_minimal.git "$FSCONF"
	fi

fi      

exec "$@"

