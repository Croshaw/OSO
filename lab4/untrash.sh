#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo 'Vvedite file name';
	exit 0;
fi
if [[ ! -f "$HOME/.trash.log" ]]; then
	echo 'File ne nayden';
	exit 0;
fi
while IFS=' : ' read -r path name || [[ -n $line ]]; do
	echo "$(basename $path)"
	if [[ "$(basename $path)" == "$1" ]]; then
		echo "Xotite vostanovit $path? (y=yes,n=no)";
		while true; do
			read input;
			echo "$input";
			if [[ "$input" == "yes" || "$input" == "y" ]]; then
				echo "$(dirname "$path")";
				if [[ ! -e $(dirname "$path") ]]; then
					path="$HOME/$(basename $path)";
					echo "Directorii yje ne suchestvuet. File budet vostonovlen v HOME";
				fi
				while true; do
					if [[ ! -f $path ]]; then
						break;
					fi
					echo "Konflict filov, vvedite novoe Im9 fila: ";
					read newFName;
					$path="$(basename $path)/$newFname";
				done
				ln -P "$HOME/name" "$path";
				rm $path;
				break;
			fi
			if [[ "$input" == "no" || "$input" == "n" ]]; then
				break;
			fi
		done	

	fi
done < "$HOME/.trash.log"
