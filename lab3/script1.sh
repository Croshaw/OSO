#!/bin/bash
StartDate=$(date '+%d-%m-%y %H:%M:%S')
mkdir ~/test 2>/dev/null && echo "catalog test was created successfully" >> ~/report && touch ~/test/"$StartDate"
ping -c 1 www.nikogo_net.ru 2>/dev/null || echo "$(date "+%d-%m-%y %H:%M:%S") ne ydaets9 pinganut'" >> ~/report
