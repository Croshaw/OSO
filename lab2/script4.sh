#!/bin/bash
if [[ -e script4.temp1.txt ]]; then
	rm script4.temp1.txt
fi

for dir in /proc/[0-9]*; do
	if [[ -d "$dir" ]]; then
		pid=$(basename $dir)
		ppid=$(awk '/PPid:/{print $2}' "$dir/status")
		sum_exec_runtime=$(awk '/se\.sum_exec_runtime /{print $3}' "$dir/sched")
		nr_switches=$(awk '/nr_switches /{print $3}' "$dir/sched")
		if [ -n "$sum_exec_runtime" ] && [ -n "$nr_switches" ] && [ "$nr_switches" -ne 0 ]; then
			art=$(echo "scale=2; $sum_exec_runtime / $nr_switches" | bc)
		else
			art="N/A"
		fi
		echo "ProcessId=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art" >> script4.temp1.txt
	fi
done
sort -t "=" -k 4 script4.temp1.txt > script4.temp.txt
rm script4.temp1.txt
cat script4.temp.txt
