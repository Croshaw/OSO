#!/bin/bash
declare -A read_bytes

for dir in /proc/[0-9]*; do
	pid=$(basename $dir)
	read_b=$(awk '/read_bytes:/{print $2}' "$dir/io")
	read_bytes[$pid]=$read_b	
done
sleep 60
for dir in /proc/[0-9]*; do
	pid=$(basename $dir)
	read_b=$(awk '/read_bytes:/{print $2}' "$dir/io")
	if [[ -n "read_bytes[$pid]" ]]; then
		read_bytes[$pid]=$(echo "$read_b - ${read_bytes[$pid]}" | bc)
	else
		read_bytes[$pid]=$read_b
	fi
done
#IFS=$'\n' sorted=($(sort -n <<<"${even[*]}"))
#unset IFS

echo "$(for key in "${!read_bytes[@]}"; do
	echo "$key:${read_bytes[$key]}"
done | sort -n -r -k 2 | head -n 3)" | while IFS=":" read -r pid read_b; do
	if [[ -f "/proc/$pid/cmdline" ]]; then
		cmdline=$(tr -d '\0' < "/proc/$pid/cmdline")
	fi
	if [[ ! -n "$cmdline" ]]; then
		cmdline="none"
	fi
	echo "$pid:$cmdline:$read_b"
done
