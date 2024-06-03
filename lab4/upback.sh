#!/bin/bash

restore_dir="$HOME/restore";
if [[ ! -d $restore_dir ]]; then
	mkdir $restore_dir;
fi
latest_folder=$(find $HOME -maxdepth 1 -type d -name "Backup-*" | sort -r | head -n 1);
if [[ -n "$latest_folder" && "$(ls -A $latest_folder)" ]]; then
	for file in "$latest_folder"/*; do
		if ! echo "$(basename $file)" | grep -qE '.*\.[0-9]{4}-[0-9]{2}-[0-9]{2}' ; then
			cp $file "$restore_dir/$(basename $file)";
		fi
	done
fi
