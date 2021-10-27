#!/bin/bash
  
rm -f /home/judge/server.log
touch ./server.log
server=$(find /home/judge -name server)

while sleep 5s
do
        if [ -f /home/judge/server.pid ]; then
                pid=$(cat /home/judge/server.pid)
        else
                echo "No active processes."
                break;
        fi

        cur=$(pidof $server)
        if [[ "$cur" == "$pid" ]]; then
                echo "Server is alive" >> /home/judge/server.log
        else
                echo "Server stopped working" >> /home/judge/server.log
                rm /home/judge/server.pid
                echo "Server pid removed." >> /home/judge/server.log
                echo "Server stopped working"
                break
        fi
done