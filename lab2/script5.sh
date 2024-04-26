#!/bin/bash
p_count=0
p_avg=0
sort -t":" -k2 script4.temp.txt | while IFS=: read -r process_info; do
	ppid=$(echo $process_info | grep -oP 'Parent_ProcessID=\K[0-9]+')
	art=$(echo $process_info | grep -oP 'Average_Running_Time=\K[^:]+')
	if [[ $ppid -eq $cur_ppid ]]; then
		p_count=$(echo "$p_count+1" | bc)
		p_avg=$(echo "scale=2; $p_avg+$art" | bc)
	else
		if [[ -n "$cur_ppid" ]]; then
			if [ -n "$p_count" ] && [ $p_count -ne 0 ]; then
				p_avg=$(echo "scale=2; $p_avg/$p_count" | bc)
			else
				p_avg="N/A"
			fi
			echo "Average_Running_Children_of_ParentID=$cur_ppid is $p_avg"
		fi
		p_count=1
		p_avg=$art
		cur_ppid=$ppid	
	fi
done

