#!/bin/sh
echo Adding user $USUARIO
supysonic-cli user add $USUARIO -p $PASSWORD
echo Changing permissions
supysonic-cli user setroles -A $USUARIO
echo Changing owner of config dir
echo Adding and scanning Library in /music
supysonic-cli folder add Library /music
supysonic-cli folder scan -f Library

gunicorn app --worker-tmp-dir /dev/shm --bind 0.0.0.0 -w ${WORKERS:-4} -t ${TIMEOUT:-180}
# sleep 4

