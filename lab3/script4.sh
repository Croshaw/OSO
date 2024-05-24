#!/bin/bash

check_cpu_usage() {
	pid=$1
	cpu_usage=$(ps -p $pid -o %cpu=)
	echo $cpu_usage
}

pids=$(pgrep -d',' -f "script4.temp.sh" | tr ',' '\n' | xargs ps -o pid= --sort=start_time)
firstPid=$(echo $pids | awk '{print $1}')
priority=0
modifier=1

while true; do
	read line
	if [ "$line" == "kill" ]; then
		echo "Kill 3 proc"
	fi
	if ps -p "$firstPid" > /dev/null; then
		curCPU=$(check_cpu_usage $firstPid)
		if [[ $(echo "$curCPU > 10" | bc -l) -eq 1 ]]; then
			echo "$curCPU > 10"
			((priority += modifier))
			#$priority=$(($priority+$modifier))
			#$priority=$(echo "$priority+$modifier" | bc -l)
		else
			echo "$curCPU < 10"
			$priority=0
		fi
		renice -n $priority -p $firstPid
	else
		break
	fi
	sleep 1
done
