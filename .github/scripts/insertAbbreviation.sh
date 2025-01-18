#!/bin/bash
wl-copy -c
wtype -M ctrl c
STRING=$(wl-paste -p)
echo $STRING
if [ -z $STRING ]; then
	echo "empty clipboard!"
else
	wl-copy "<abbr title=' '>$STRING</abbr>"
	wtype -M ctrl v 
	sleep 0.1
	#exit
	wtype -M ctrl -P left -P left -P left -P left -P left -m ctrl -P left
fi
#wl-copy -c
