#!/bin/bash
str="";
while true; do
	read tempStr;
	if [[ "$tempStr" == "q" ]] then
		break;
	fi
	str="$str$tempStr";
done
echo $str;
