#!/bin/bash

check_cpu_usage() {
	pid=$1
	cpu_usage=$(top -n 1 -b -p $pid | tail -n 1 | awk '{print $9}')
	echo $cpu_usage
}

pids=$(pgrep -d',' -f "script4.temp.sh" | tr ',' '\n' | xargs ps -o pid= --sort=start_time)
firstPid=$(echo $pids | awk '{print $1}')
priority=0
modifier=1
function main_loop() {
	while true; do		
		if ps -p "$firstPid" > /dev/null; then
			curCPU=$(check_cpu_usage $firstPid)
			if [[ $(echo "$curCPU > 10" | bc -l) -eq 1 ]]; then
				echo "$curCPU > 10"
				((priority += modifier))
#			else
				#echo "$curCPU < 10"
				#((priority -= modifier))
				#
			fi
			renice -n $priority -p $firstPid > /dev/null
		else
			break
		fi
		sleep 1
	done
}
main_loop &
while true; do
	read line
	if [ "$line" == "kill" ]; then
		killpid=$(echo $pids | awk '{print $3}')
		kill $killpid && echo "Process with PID=$killpid was killed"
	fi
done
