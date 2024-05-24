#!/bin/bash

check_cpu_usage() {
	pid=$1
	cpu_usage=$(ps -p $pid -o %cpu=)
	echo $cpu_usage
}

pids=$(pgrep -d',' -f "$1" | tr ',' '\n' | xargs ps -o pid= --sort=start_time)
firstPid = echo $pids | head -n 1

while true do
	if ps -p "$firstPid" > /dev/null; then
		if [[ $(echo "$(check_cpu_usage $firstPid) > 10" | bc -l) ]]; then
			echo "> 10"
			renice -n 19 -p $firstPid
		else
			echo "< 10"
			renice -n 0 -p $firstPid
		fi
	else
		break
	fi
done
