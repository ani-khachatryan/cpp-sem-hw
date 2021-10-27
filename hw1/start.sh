#!/bin/bash

server=$(find /home/judge -name server)
nohup $server > /dev/null 2>&1 &
if [ $? -eq 0 ]; then

        echo "Server's up."
        rm -f /home/judge/server.pid
        touch /home/judge/server.pid
        pidof $server > /home/judge/server.pid

        rm -f /home/judge/server.log
        touch /home/judge/server.log

        healthcheck=$(find -name healthcheck.sh)
        #echo "$healthcheck"
        nohup $healthcheck > /dev/null 2>&1 &
else
        echo ":( :( :( :("
fi