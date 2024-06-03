#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo 'Vvedite file name';
	exit 0;
fi
if [[ ! -f "$HOME/.trash.log" ]]; then
	echo 'File ne nayden';
	exit 0;
fi
while IFS=' : ' read -r path name; do
	#echo "$(basename $path)"
	if [[ "$(basename $path)" == "$1" ]]; then
		echo "Xotite vostanovit $path? (y=yes,n=no)";
		while true; do
			read -r input <&1;
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
					read -r newFName <&1;
					#echo "$(dirname $path)";
					path="$(dirname $path)/$newFName";
					#echo "$path";
				done
				ln -P "$HOME/.trash/$name" "$path";
				rm "$HOME/.trash/$name";
				break;
			fi
			if [[ "$input" == "no" || "$input" == "n" ]]; then
				echo "$path : $name" >> "$HOME/.temp.rem";
				break;
			fi
		done
	else
		echo "$path : $name" >> "$HOME/.temp.rem";
	fi
done < "$HOME/.trash.log";
if [[ -f "$HOME/.temp.rem" ]]; then
	cat "$HOME/.temp.rem" > "$HOME/.trash.log";
	rm "$HOME/.temp.rem";
fi
