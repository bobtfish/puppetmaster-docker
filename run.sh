#!/bin/bash

if [ "$(hostname)" != "puppetmaster" ];then
  echo "Please docker run --hostname puppetmaster"
  exit 1
fi

# Default argument
if [ "$1" == "run" ];then
  puppet master --no-daemonize --verbose &
  sleep 5
  kill $(cat $(puppet master --configprint pidfile))
  supervisord -n -c /etc/supervisor/supervisord.conf
else
  # Anything else :)
  eval "$*"
fi

