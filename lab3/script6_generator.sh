#!/bin/bash
 
while true
do
    read input
    if [ "$input" = "+" ]; then
        kill -s USR1 $1
    elif [ "$input" = "*" ]; then
        kill -s USR2 $1
    elif [ "$input" = "TERM" ]; then
        kill -s SIGTERM $1
        break
    fi
done
