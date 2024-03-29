#!/bin/bash
if [[ "$PWD" == "$HOME" ]]; then
	echo $HOME
	exit 0
fi
echo "ERROR"
exit 1
