#!/bin/bash
 
value=1
 
trap 'value=$((value + 2))' USR1
trap 'value=$((value * 2))' USR2
trap 'echo "Handler process terminated"; exit' SIGTERM 
while true
do
	if [ "$value" != "$lastvalue" ]; then
		lastvalue=$value
		echo "Current value: $value"
	fi
	sleep 1
done
