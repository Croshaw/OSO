#!/bin/bash
echo $'[1] - vim\n[2] - dolphin\n[3] - links\n[4] - Exit'
read choose
case $choose in
	1 )
		nvim
		;;
	2 )
		dolphin
		;;
	3 )
		echo "Open a links"
		;;
esac
