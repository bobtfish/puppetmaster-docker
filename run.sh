#!/bin/bash

# Default argument
if [ "$1" == "run" ];then
  /usr/sbin/nginx
  exec supervisord -n -c /etc/supervisor/supervisord.conf
fi
# Anything else :)
eval "$*"


