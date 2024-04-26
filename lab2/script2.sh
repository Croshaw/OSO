#!/bin/bash
if [[ $# -ne 2 ]] then
	echo "Vvedite username and peace of command"
	exit 0;
fi
result=$(ps -u "$1" --no-headers -o pid,cmd)
echo "$result" | grep $2 > script2.temp.txt
cat script2.temp.txt
