#!/bin/bash
process_count="0"
process_art="0"
sort -t":" -k2 script4.temp.txt | while IFS=: read -r process_info; do
parent_id=$(echo $process_info | grep -oP 'Parent_ProcessID=\K[0-9]+')
art=$(echo $process_info | grep -oP 'Average_Running_Time=\K[^:]+')
if [[ "$parent_id" -eq "$current_parent_id" ]]; then
	process_count=$(echo "$process_count + 1" | bc)
	process_art=$(echo "scale=2; $art + $process_art" | bc)
else
	if [[ -n "$current_parent_id" ]]; then
		if [ -n "$process_count" ] && [ $process_count -ne 0 ]; then
			avg=$(echo "$process_art/$process_count" | bc)
		else
			avg="N/A"
		fi
		#echo "Average_Running_Children_Of_ParentID=$parent_id is $avg"
		process_count="0"
		process_art="0"
	else
		current_parent_id=$parent_id
	fi
fi
done

