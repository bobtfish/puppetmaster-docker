#!/bin/bash

# Default argument
if [ "$1" == "run" ];then
  /usr/sbin/nginx
  exec supervisord -n
fi
# Anything else :)
eval "$*"


