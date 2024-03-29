#!/bin/bash
if [[ $# -ne 3 ]] then
	echo "Vvedite 3 parametra!";
	exit 0;
fi
let max=$1;
if [[ $max -lt $2 ]] then
	max=$2;
fi
if [[ $max -lt $3 ]] then
	max=$3;
fi
echo "Max is $max";
exit 0;
