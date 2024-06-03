#!/bin/bash
if [[ $# -eq 0 ]]; then
	echo 'Ykajite file';
	exit 0;
fi
if [[ ! -f $1 ]]; then
	echo 'File ne naiden';
	exit 0;
fi
if [[ ! -d "$HOME/.trash" ]]; then
	mkdir "$HOME/.trash";
fi
newName=$(ls -l "$HOME/.trash" | wc -l);
ln -P $1 "$HOME/.trash/$newName";
rm $1;
echo "$(dirname $(realpath $0))/$1 : $newName" >> "$HOME/.trash.log";
