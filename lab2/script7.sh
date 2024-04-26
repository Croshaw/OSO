#!/bin/bash
declare -a read_bytes

for dir in /proc/[0-9]*; do
	pid=$(basename $dir)
	read=$(awk '/read_bytes:/{print $2}' "$dir/io")
	read_bytes[$pid]=read	
done
sleep 10
for dir in /proc/[0-9]*; do
	pid=$(basename $dir)
	read=$(awk '/read_bytes:/{print $2}' "$dir/io")
	if [[ -n "read_bytes[$pid]" ]]; then
		read_bytes[$pid]=$(echo "$read - $read_bytes[$pid]" | bc)
	else
		read_bytes[$pid]=$read
	fi
done
IFS=$'\n' sorted=($(sort -n <<<"${even[*]}"))

for value in "${sorted[@]}"; do
	echo "$value"
done
