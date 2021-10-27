#!/bin/bash
  
proc=$(cat /home/judge/server.pid)

kill $proc
