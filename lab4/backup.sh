#!/bin/bash
current_date=$(date +%Y-%m-%d)

function backup {
	backup_dir=$1;
	source_dir="$HOME/source";
	if [[ -d $source_dir ]]; then
		for file in "$source_dir"/*; do
			newFile="$backup_dir/$(basename $file)";
			if [[ -f $newFile ]]; then
				newFileSize=$(stat -c %s $newFile);
				fileSize=$(stat -c %s $file);
				if [[ $newFileSize -ne $fileSize ]]; then
					cp $newFile "$(dirname $newFile)/$(basename $newFile).$current_date";
					echo "$(basename $newFile) : $(basename $newFile).$current_date" >> "$HOME/backup2.temp";
				fi
			else
				echo "$(basename $newFile)" >> "$HOME/backup1.temp";
			fi
			cp $file "$backup_dir/$(basename $file)";
		done
		if [[ -f "$HOME/backup1.temp" ]]; then
			cat "$HOME/backup1.temp" >> "$HOME/backup-report";
			rm "$HOME/backup1.temp";
		fi
		if [[ -f "$HOME/backup2.temp" ]]; then
			cat "$HOME/backup2.temp" >> "$HOME/backup-report";
			rm "$HOME/backup2.temp";
		fi
	fi
}

for ((i=0; i<=7; i++)); do
	backup_date=$(date -d "$current_date -$i days" +%Y-%m-%d)
	backup_dir="$HOME/Backup-$backup_date";
	if [[ -d $backup_dir ]]; then
		echo "Backup folder was updated ($backup_dir)" >> "$HOME/backup-report";
		backup $backup_dir;
		exit 0;
	fi
done
backup_dir="$HOME/Backup-$current_date";
mkdir $backup_dir;
echo "Backup folder was created ($backup_dir)" >> "$HOME/backup-report";
backup $backup_dir;
