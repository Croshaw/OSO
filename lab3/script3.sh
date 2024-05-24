#!/bin/bash
days=(1 2 3 4 5 6)
while true
do
	day_of_week=$(date +%u)
	if [[ " ${days[@]} " =~ " $day_of_week " ]]; then
		#hours=$(date +%-H)
		minutes=$(date +%-M)
		#seconds=$(date +%-S)
		if [[ $(($minutes % 5)) -eq 0 ]]; then
			./script1.sh &
			echo "GOOD"
			sleep 60
		fi
	fi
done
