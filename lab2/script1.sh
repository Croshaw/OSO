#!/bin/bash
if [[ $# -ne 1 ]] then
	echo "Vvedite username";
	exit 0;
fi

result=$(ps -u "$1" --no-headers -o pid,cmd)
count=$(echo "$result" | wc -l)
echo "Count proccesses by $1: $count" > script1.temp.txt
echo "$result" | awk '{print $1 ":" $2}' >> script1.temp.txt
