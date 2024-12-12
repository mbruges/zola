#!/bin/bash
	
#A script for updating an IFRAME with new URL

## REQUIRES - marp, gum, micro

#pathToIframePage="../marp_live/live.html"

## 09/06 - switching to NTFY powered SSE. The liveURL file is no longer used
# Also - switching to CURL so it's more portable, though gum is still a dependency


## 10/06
# Adding two options to initial selector: 'clear' and 'message'. Message lets you write a message in Markdown in Nano.

# Also, re-writing the HTML to not do the polling. This seems to cause issues (possibly cloudflare CDN?).
# Instead, going back to having a file containing the last received message, hosted at ./liveURL
# This file is updated with a cUrl shell script - sseListener.sh - because I can't figure out how to get NTFY to do it automatically 


## 13/06
# Have added an autotimeout on the server: 'abort' will be sent to liveURL when no slide changes have been received for an hour (running on a periodical cronjob)

pathToHTML=$@ 
clear
#Quick connection check
if ! curl -fs -o /dev/null 1.1.1.1; then
    echo "Connection error, unable to reach Internet ⚠️"
    sleep 3
    exit
fi

echo "End lesson 🚫" > list.temp
echo "Refresh page ♻️" >> list.temp
echo "Post message 📋" >> list.temp
ls -t -1 *.html >> list.temp
ls -t -1 textbook/*.html >> list.temp

if [ -z "${pathToHTML}" ]; then
    pathToHTML=$(cat list.temp | gum filter --limit=1 --header.foreground="212"  --header="Choose live page" --placeholder="Type..." --indicator="👉") || exit
    rm list.temp
fi

#pathToHTML=$(echo $pathToHTML | sed 's/.*\/\([^\/]*\)$/\1/')

if [[ $(echo "$pathToHTML" | grep -i "end") ]]; then
    gum spin -s moon --title 'Closing live lesson...' -- gum spin --title="Refreshing Live View..." -- socksend --address "wss://socket.maxbruges.com/ws?key=Martha111" --quiet --message "abort"  || echo "Failed to end lesson 🚫"
    exit
elif [[ $(echo "$pathToHTML" | grep -i "message") ]]; then
    echo -e "---\nmarp: true\ntheme: rab\nauthor: Max Bruges\ntitle: Message\n---\n\n <!-- Press Ctrl+Q when you're finished -->\n\n\n" > ../message.md
    #nano +8 -tqx --softwrap ../message.md
    micro -statusline false -infobar false -softwrap true -autosave 10 -cursorline false +9 ../message.md
    gum spin --title="Converting message..." -- bash ../scripts/marp_sync.sh  message
    #mv ../message.md message.md
    pathToHTML="message.html"
    SLIDE="1"
elif [[ $(echo "$pathToHTML" | grep -i "refresh") ]]; then
    gum spin -s globe --title "♻️ Refreshing..." -- socksend --address "wss://socket.maxbruges.com/ws?key=Martha111" --quiet --message "refresh" || echo "Failed to send refresh command 🚫";
    exit;
else
    SLIDE=$(gum input --prompt "Start $pathToHTML at slide: " --placeholder "Enter number")
fi

if [[ "$SLIDE" =~ ^[0-9]+$ ]]; then
    SLIDE=$SLIDE
else
    SLIDE=1
fi

gum spin -s globe --title "Starting $pathToHTML live lesson at slide $SLIDE..." -- socksend --address "wss://socket.maxbruges.com/ws?key=Martha111" --quiet --message "$pathToHTML#$SLIDE" || echo "Failed to start live lesson 🚫"

while true
do
    CHOICE=$(gum filter --limit=1 --header="🔴 LIVE: $pathToHTML on slide: $SLIDE" --header.foreground="212" --selected-indicator.background="212" --placeholder="  Current slide: $SLIDE" "Next →" "Previous ←" "End lesson 🚫" "Refresh viewer ♻️")
    if [[ $CHOICE == "Next →" ]]; then
        ((SLIDE++));
	 	gum spin -s line --title "Changing to slide $SLIDE..." -- socksend --address "wss://socket.maxbruges.com/ws?key=Martha111" --quiet --message "$pathToHTML#$SLIDE"  || echo -n "Unable to change slide"
    elif [[ $CHOICE == "Previous ←" ]]; then
        ((SLIDE--));
        if [[ "$SLIDE" -lt 1 ]]; then
            SLIDE=1
        fi
	 	gum spin -s line --title "Changing to slide $SLIDE..." -- socksend --address "wss://socket.maxbruges.com/ws?key=Martha111" --quiet --message "$pathToHTML#$SLIDE" || echo -n "Unable to change slide"
    elif [[ $CHOICE == "End lesson 🚫" ]]; then
        gum spin -s moon --title 'Closing live lesson...' -- socksend --address "wss://socket.maxbruges.com/ws?key=Martha111" --quiet --message "abort";
        exit;
    elif [[ $CHOICE == "Refresh viewer ♻️" ]]; then
        gum spin -s globe --title "♻️ Refreshing..." -- socksend --address "wss://socket.maxbruges.com/ws?key=Martha111" --quiet --message "refresh" || echo "Failed to send refresh command 🚫";
    else
        exit 1;
    fi
done
