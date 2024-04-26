#!/bin/bash
max_pid=""
max=0
for dir in /proc/[0-9]*; do
	if [[ -d "$dir" ]]; then
		mem=$(awk '/VmRSS:/{print $2}' "$dir/status")
		if [[ mem -gt max ]]; then
			max_pid=$(basename $dir)
			max=$mem
		fi
	fi
done
echo "$max_pid : $max"
#cat "/proc/$max_pid/status"
top -o %MEM -b -n 1 | tail -n +7 | head -n 2
